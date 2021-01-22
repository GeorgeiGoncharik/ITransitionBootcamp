import Foundation

enum ArticleError: Error {
    case parsing(description: String)
    case network(description: String)
}
