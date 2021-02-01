import Foundation
import CoreData

class NoteDetailViewModel: ObservableObject {
    @Published private(set) var note: Note
    
    private var context: NSManagedObjectContext
    
    init(note: Note){
        context = PersistenceController.shared.container.viewContext
        self.note = note
    }

    func savePressed(){
        note.editDate = Date()
        context.saveWithoutTry()
    }
    
    func deletePressed(){
        guard let bookmark = note.bookmark else {return}
        bookmark.removeFromNotes(note)
        context.delete(note)
        context.saveWithoutTry()
    }
}
