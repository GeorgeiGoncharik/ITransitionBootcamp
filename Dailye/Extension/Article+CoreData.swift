import Foundation
import CoreData

extension Article{
    func asBookmark(with context: NSManagedObjectContext) -> Bookmark{
        let bookmark = Bookmark(context: context)
        bookmark.sourceId = self.source.id
        bookmark.sourceName = self.source.name
        bookmark.author = self.author
        bookmark.title = self.title
        bookmark.bookmarkDescription = self.articleDescription
        bookmark.url = self.url
        bookmark.urlToImage = self.urlToImage
        bookmark.publishedAt = self.publishedAt
        return bookmark
    }
}
