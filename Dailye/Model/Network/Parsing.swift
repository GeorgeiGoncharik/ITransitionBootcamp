import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error>{
    let decoder = iso8601JSONDecoder()
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError{ error in
            ArticleError.network(description: error.localizedDescription)
            
        }
        .eraseToAnyPublisher()
}
