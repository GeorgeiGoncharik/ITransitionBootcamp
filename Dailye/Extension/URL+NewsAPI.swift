import Foundation

extension URL {
    private static var baseUrl: String {
        return "https://newsapi.org/v2/"
    }
    
    private static var apiKey: String {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path){
                let secret = dict["NewsAPIKey"] as! String
                return secret
            }
        }
        return "bogus"
    }
    
    static func with(string: String) -> URL? {
        return URL(string: "\(baseUrl)\(string)&\(apiKey)")
    }
}
