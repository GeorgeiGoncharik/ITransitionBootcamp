import Foundation

struct Article: Codable, Identifiable {
    let id = UUID()
    let source: Source
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
    
    var publishedAtText: String{
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.allowedUnits = [.day, .hour, .minute]
         
        if let published = publishedAt{
            let outputString = formatter.string(from: published, to: Date())!
            return outputString + " ago"
        }
        return "published recently"
    }
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
