import Foundation
import CoreData

class BookmarkDetailViewModel: ObservableObject {
    @Published var notes = [Note]()
    @Published var bookmark: Bookmark
    @Published var passwordField = ""
    private var context: NSManagedObjectContext
    
    init(bookmark: Bookmark) {
        context = PersistenceController.shared.container.viewContext
        self.bookmark = bookmark
    }
    
    func deleteBookmark() {
        context.delete(bookmark)
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addNote(){
        let note = Note(context: context)
        note.createDate = Date()
        bookmark.addToNotes(note)
        do {
            try context.save()
            convertNotesToArray()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func convertNotesToArray(){
        notes = (bookmark.notes as? Set<Note> ?? []).sorted(by: {$0.createDate! < $1.createDate!})
    }
}
