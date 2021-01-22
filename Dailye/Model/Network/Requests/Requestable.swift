import Foundation

protocol Requestable {
    var endpoint: String {get}
    var params: String {get}
    mutating func nextPage() -> Void
}
