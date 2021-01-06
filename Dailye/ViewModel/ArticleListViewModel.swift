import Foundation
import Combine

class ArticleListViewModel: ObservableObject{
    @Published var response: ArticleListResponse?
    @Published var articles: [Article] = []
    @Published var state = State.ready

    enum State {
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    var url = URL.with(string: "top-headlines?country=us")! //bogus
    var urlSession = URLSession.shared
    var dataTask: AnyPublisher<ArticleListResponse, Error>{
        self.urlSession
            .dataTaskPublisher(for: self.url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
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
             receiveValue: { value in
                 self.state = .loaded
                 self.response = value
                 self.articles = value.articles ?? []
             }
         ))
    }
    
    func loadIfNeeded() {
        assert(Thread.isMainThread)
        guard case .ready = self.state else { return }
        self.load()
    }
}
