import Foundation
import CoreData

@objc(ArticleEntity)
public class ArticleEntity: NSManagedObject, Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(url ?? "blank", forKey: .url)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
        let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: "ArticleEntity", in: managedObjectContext)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = UUID()
            source = try values.decode(SourceEntity.self, forKey: .source)
            author = try values.decode(String.self, forKey: .author)
            title = try values.decode(String.self, forKey: .title)
            articleDescription = try values.decode(String.self, forKey: .articleDescription)
            url = try values.decode(String.self, forKey: .url)
            urlToImage = try values.decode(String.self, forKey: .urlToImage)
            publishedAt = try values.decode(Date.self, forKey: .publishedAt)
            content = try values.decode(String.self, forKey: .content)
        } catch {
            print ("error")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
