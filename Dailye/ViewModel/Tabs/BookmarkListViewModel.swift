import Foundation
import CoreData

class BookmarkListViewModel: ObservableObject {
    @Published var bookmarks = [Bookmark]()
    private var context: NSManagedObjectContext
    
    init() {
        context = PersistenceController.shared.container.newBackgroundContext()
        fetchBookmarks()
    }
    
    func fetchBookmarks(){
        let request: NSFetchRequest<Bookmark> = Bookmark.fetchRequest()
        do{
            bookmarks = try context.fetch(request)
        } catch {
            bookmarks = []
        }
    }
}
