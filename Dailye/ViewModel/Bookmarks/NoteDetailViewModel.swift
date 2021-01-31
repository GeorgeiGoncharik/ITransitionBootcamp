import Foundation
import CoreData

class NoteDetailViewModel: ObservableObject {
    @Published var note: Note
    
    private var context: NSManagedObjectContext
    
    init(note: Note){
        context = PersistenceController.shared.container.viewContext
        self.note = note
    }

    func savePressed(){
        do {
            note.editDate = Date()
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deletePressed(){
        guard let bookmark = note.bookmark else {return}
        bookmark.removeFromNotes(note)
        context.delete(note)
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
