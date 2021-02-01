import Foundation
import Combine

class ArticleListViewModel: ObservableObject{
    @Published private(set) var articles: [Article] = []
    @Published private(set) var state = State.ready
    private var request: Requestable
    private let articleFetcher: ArticleFetchable
    
    init(request: Requestable) {
        self.articleFetcher = ArticleFetcher()
        self.request = request
    }

    enum State {
        case ready
        case loading(Cancellable)
        case loaded
        case done
        case error(Error)
    }
        
    func load(){
        self.state = .loading(
            articleFetcher.getArticleListResponse(with: request)
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
                        self.articles += articles
                    }
                )
        )
    }
    
    func loadIfNeeded() {
        guard case .ready = self.state else { return }
        self.load()
    }
    
    func loadMore() {
        request.nextPage()
        self.load()
    }
}
