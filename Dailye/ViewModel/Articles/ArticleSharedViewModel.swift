import Foundation
import CoreData

class ArticleSharedViewModel: ObservableObject {
    @Published private(set) var article: Article
    @Published private(set) var isBookmarked: Bool = false
    private var context: NSManagedObjectContext
    
    init(article: Article) {
        self.article = article
        context = PersistenceController.shared.container.newBackgroundContext()
    }
        
    func addBookmark(){
        guard fetchBookmark() == nil else {
            return
        }
        _ = article.asBookmark(with: context)
        context.saveWithoutTry()
        isBookmarked = true
    }
    
    func deleteBookmark() {
        guard let bookmark = fetchBookmark() else {
            return
        }
        context.delete(bookmark)
        context.saveWithoutTry()
        isBookmarked = false
    }
    
    func checkIfBookmark() {
        isBookmarked =
            fetchBookmark() != nil
            ? true
            : false
    }
    
    private func fetchBookmark() -> Bookmark?{
        let request = NSFetchRequest<Bookmark>(entityName: "Bookmark")
        request.predicate = NSPredicate(format: "url == %@", article.url ?? "")
        request.fetchLimit = 1
        do{
            return try context.fetch(request).first
        } catch {
            let error = error as NSError
            fatalError(error.localizedDescription)
        }
    }
}
