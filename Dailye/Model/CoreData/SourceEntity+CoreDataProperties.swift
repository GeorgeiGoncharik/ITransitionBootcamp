import Foundation
import CoreData


extension SourceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceEntity> {
        return NSFetchRequest<SourceEntity>(entityName: "SourceEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var articles: NSSet?

}

// MARK: Generated accessors for articles
extension SourceEntity {

    @objc(addArticlesObject:)
    @NSManaged public func addToArticles(_ value: ArticleEntity)

    @objc(removeArticlesObject:)
    @NSManaged public func removeFromArticles(_ value: ArticleEntity)

    @objc(addArticles:)
    @NSManaged public func addToArticles(_ values: NSSet)

    @objc(removeArticles:)
    @NSManaged public func removeFromArticles(_ values: NSSet)

}

extension SourceEntity : Identifiable {

}
