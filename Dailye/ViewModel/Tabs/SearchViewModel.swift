import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published private(set) var articles: [Article] = []
    @Published private(set) var state = State.ready
    @Published var search: String = ""
    
    private var scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    private let articleFetcher: ArticleFetchable = ArticleFetcher()
    private var disposables = Set<AnyCancellable>()
    
    enum State {
        case ready
        case loading(Cancellable)
        case loaded
        case done
        case error(Error)
    }
    
    init() {
        $search
            .dropFirst(1)
            .debounce(for: .seconds(1.0), scheduler: scheduler)
            .sink(receiveValue: load(for:))
            .store(in: &disposables)
    }
    
    func load(for search: String){
        articleFetcher.getArticleListResponse(
            with: EverythingRequest(
                q: search,
                sortingStrategy: .popularity,
                pageSize: 100
            )
        )
        .map{ response in response.articles ?? [] }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.state = .error(error)
                }
            },
            receiveValue: { [weak self] articles in
                guard let self = self else {return}
                self.state = articles.isEmpty ? .done : .loaded
                self.articles = articles
            }
        )
        .store(in: &disposables)
    }
}
