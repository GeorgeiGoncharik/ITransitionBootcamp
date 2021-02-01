import SwiftUI
import URLImage

struct BookmarkDetail: View {
    @Environment(\.presentationMode) var presentation
    @StateObject private var viewModel: BookmarkDetailViewModel
    
    init(_ bookmark: Bookmark) {
        _viewModel = StateObject(wrappedValue: BookmarkDetailViewModel(bookmark: bookmark))
    }
    
    var body: some View {
        ZStack{
            ScrollView{
                Link(destination: URL(string: viewModel.bookmark.url ?? "https://404.com")!, label: {
                    BookmarkRow(bookmark: viewModel.bookmark)
                })
                ForEach(viewModel.notes, id: \.self){ note in
                    NavigationLink(
                        destination: NoteDetail(note: note),
                        label: {
                            NoteRow(note: note)
                                .padding()
                        })
                }.onAppear{ viewModel.convertNotesToArray() }
            }
            
            VStack{
                Spacer().layoutPriority(5)
                HStack{
                    Spacer().layoutPriority(5)
                    Button(action: viewModel.addNote, label: {
                        Image(systemName: "note.text.badge.plus")
                            .padding()
                            .cardLook()
                            .padding()
                    })
                }
            }
        }
        .blur(radius: viewModel.state == AuthenticationState.loggedout ? 10.0 : 0.0)
        .disabled(viewModel.state == AuthenticationState.loggedout)
        .navigationTitle(viewModel.bookmark.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            HStack{
                Button(action: {
                    presentation.wrappedValue.dismiss()
                    viewModel.toggleNotePrivacy()
                }) {
                    Image(systemName: viewModel.bookmark.isSecured
                        ? "checkmark.shield.fill"
                        : "lock")
                }
                
                Button(action: {
                    presentation.wrappedValue.dismiss()
                    viewModel.deleteBookmark()
                }) {
                    Image(systemName: "bookmark.slash")
                        .padding(.leading)
                }
            }
        )
    }    
    //MARK: - Constants
    let cornerRadius: CGFloat = 25
    let shadowRadius: CGFloat = 4
    let descriptionLineLimit: Int = 2
    let smallPadding: CGFloat = 1
    let footLineLimit: Int = 1
}
