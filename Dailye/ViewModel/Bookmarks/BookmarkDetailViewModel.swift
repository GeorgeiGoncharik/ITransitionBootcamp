import Foundation
import CoreData
import LocalAuthentication

class BookmarkDetailViewModel: ObservableObject {
    @Published var notes = [Note]()
    @Published var bookmark: Bookmark
    @Published var passwordField = ""
    private var context: NSManagedObjectContext
    private var LAcontext: LAContext
        
    @Published var state: AuthenticationState = .loggedout
    
    init(bookmark: Bookmark) {
        context = PersistenceController.shared.container.viewContext
        LAcontext = LAContext()
        self.bookmark = bookmark
        authenticate()
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
    
    func authenticate() {
        LAcontext = LAContext()
        LAcontext.localizedCancelTitle = "Try again"
        var error: NSError?
        if LAcontext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Unlock notes"
            LAcontext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                if success {
                    DispatchQueue.main.async { [unowned self] in
                        self.state = .loggedin
                    }
                } else {
                    print(error?.localizedDescription ?? "Failed to authenticate")
                }
            }
        } else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
        }
    }
    
    func convertNotesToArray(){
        notes = (bookmark.notes as? Set<Note> ?? []).sorted(by: {$0.createDate! < $1.createDate!})
    }
}
