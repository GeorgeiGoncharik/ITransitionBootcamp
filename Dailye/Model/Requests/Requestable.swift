import Foundation

protocol Requestable {
    var endpoint: String {get}
    func makeQueryParams() -> String
    mutating func nextPage() -> Void
}
