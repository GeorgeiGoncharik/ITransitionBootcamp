import Foundation
import CoreData

class ArticleSharedViewModel: ObservableObject {
    @Published var article: Article
    @Published var isBookmarked: Bool = false
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
        do {
            try context.save()
            isBookmarked = true
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteBookmark() {
        guard let bookmark = fetchBookmark() else {
            return
        }
        context.delete(bookmark)
        do {
            try context.save()
            isBookmarked = false
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func checkIfBookmark() {
        isBookmarked =
            fetchBookmark() != nil
            ? true
            : false
    }
    
    private func fetchBookmark() -> Bookmark?{
        let request = NSFetchRequest<Bookmark>(entityName: "Bookmark")
        request.predicate = NSPredicate(format: "id == %@", article.id.uuidString)
        request.fetchLimit = 1
        do{
            return try context.fetch(request).first
        } catch {
            let error = error as NSError
            fatalError(error.localizedDescription)
        }
    }
}
