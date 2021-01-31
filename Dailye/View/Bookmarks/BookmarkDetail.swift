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
                cardBody
                
                if (viewModel.bookmark.password == nil) {
                    HStack{
                        SecureField("password (optional)", text: $viewModel.passwordField){
                            viewModel.passwordField.isEmpty ? background(Color.red) : background(Color.primary)
                        }
                            .padding()
                            .cardLook()
                        
                        Button(action: {}){
                            Image(systemName: "lock.open")
                                .padding()
                                .cardLook()
                        }
                    }.padding()
                }
                
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
        .navigationTitle(viewModel.bookmark.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Button(action: {
                presentation.wrappedValue.dismiss()
                viewModel.deleteBookmark()
            }) {
                Image(systemName: "bookmark.slash")
            }
        )
    }
    
    private var cardBody: some View{
        VStack(alignment: .leading, spacing: 10){
            if let urlToImage = viewModel.bookmark.urlToImage, let url = URL(string: urlToImage){
                    URLImage(url: url,
                             empty: { EmptyView() },
                             inProgress: { _ in EmptyView() },
                             failure: { _, _ in Text("Downloading has failed!")
                             },
                             content: { image, _ in
                                 image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(cornerRadius)
                             })
                    
                if let title = viewModel.bookmark.title{
                        Title(title, with: .horizontal)
                    }
                    
                } else {
                    
                    if let title = viewModel.bookmark.title{
                        Title(title, with: [.horizontal, .top])
                    }
                }
                Group{
                    if let desc = viewModel.bookmark.bookmarkDescription{
                        Text(desc)
                            .lineLimit(descriptionLineLimit)
                            .font(.subheadline)
                            .cardText()
                    }
                    HStack{
                        Text("・\(viewModel.bookmark.publishedAt ?? Date())")
                            .font(.footnote)
                            .lineLimit(footLineLimit)
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.bottom)
                }
                .padding(.horizontal)
            
            Spacer()
        }
        .cardLook()
        .padding()
    }
    
    func Title(_ title: String, with edges: Edge.Set) -> some View{
        Text(title)
            .padding(edges)
            .font(.title3)
            .cardText()
    }
    
    //MARK: - Constants
    let cornerRadius: CGFloat = 25
    let shadowRadius: CGFloat = 4
    let descriptionLineLimit: Int = 2
    let smallPadding: CGFloat = 1
    let footLineLimit: Int = 1
}
