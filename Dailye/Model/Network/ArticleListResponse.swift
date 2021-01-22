import Foundation

struct ArticleListResponse: Codable {
    let status: String
    let code: String?
    let message: String?
    let totalResults: Int?
    let articles: [Article]?
}
