import Foundation

protocol Requestable {
    var endpoint: String {get}
    func makeQueryParams() -> String
}
