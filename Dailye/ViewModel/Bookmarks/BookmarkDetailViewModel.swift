import Foundation
import CoreData
import LocalAuthentication

class BookmarkDetailViewModel: ObservableObject {
    @Published private(set) var notes = [Note]()
    @Published private(set) var bookmark: Bookmark
    private var context: NSManagedObjectContext
    private var LAcontext: LAContext
        
    @Published var state: AuthenticationState = .loggedout
    
    init(bookmark: Bookmark) {
        context = PersistenceController.shared.container.viewContext
        LAcontext = LAContext()
        self.bookmark = bookmark
        if self.bookmark.isSecured == true{
            authenticate()
        } else {
            state = .loggedin
        }
        convertNotesToArray()
    }
    
    func deleteBookmark() {
        context.delete(bookmark)
        context.saveWithoutTry()
    }
    
    func addNote(){
        let note = Note(context: context)
        note.createDate = Date()
        bookmark.addToNotes(note)
        context.saveWithoutTry()
        convertNotesToArray()
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
    
    func toggleNotePrivacy(){
        self.bookmark.isSecured = bookmark.isSecured ? false : true
        context.saveWithoutTry()
    }
    
    func convertNotesToArray(){
        notes = (bookmark.notes as? Set<Note> ?? []).sorted(by: {$0.createDate! < $1.createDate!})
    }
}
