import Foundation
import Combine

class ArticleListViewModel: ObservableObject{
    @Published private(set) var articles: [Article] = []
    @Published private(set) var state = State.ready
    private var request: Requestable
    
    init(request: Requestable) {
        self.request = request
    }

    enum State {
        case ready
        case loading(Cancellable)
        case loaded
        case done
        case error(Error)
    }
    
    private var urlSession = URLSession.shared
    private var dataTask: AnyPublisher<ArticleListResponse, Error>{
        self.urlSession
            .dataTaskPublisher(for: URL.with(request: request)!)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
                }
            .decode(type: ArticleListResponse.self, decoder: newJSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func load(){
        assert(Thread.isMainThread)
        self.state = .loading(self.dataTask.sink(
             receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     break
                 case let .failure(error):
                     self.state = .error(error)
                 }
             },
             receiveValue: { response in
                if let arts = response.articles, arts.count > 0{
                    self.state = .loaded
                    self.articles += arts
                } else {
                    self.state = .done
                }
             }
         ))
    }
    
    func loadIfNeeded() {
        assert(Thread.isMainThread)
        guard case .ready = self.state else { return }
        self.load()
    }
    
    func loadNextPage() {
        assert(Thread.isMainThread)
        request.nextPage()
        self.load()
    }
}
