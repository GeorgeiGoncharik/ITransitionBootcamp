import Foundation
import Combine

protocol ArticleFetchable{
    func getArticleListResponse(
        with request: Requestable
    ) -> AnyPublisher<ArticleListResponse, Error>
}

extension ArticleFetchable{
    func getArticleListResponse(
        with request: Requestable
    ) -> AnyPublisher<ArticleListResponse, Error>{
        return response(for: request)
    }
    
    private func response<T>(
        for request: Requestable
    ) -> AnyPublisher<T, Error> where T: Decodable {
        guard let url = URL.with(request: request) else {
            let error = ArticleError.network(description: "Couldn't create URL.")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError{ error in
                ArticleError.network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)){ pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}
