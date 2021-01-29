import SwiftUI
import URLImage

struct ArticleDetail: View {
    @StateObject private var viewModel: ArticleSharedViewModel
    @State private var showShareSheet = false
    
    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleSharedViewModel(article: article))
    }
    
    var body: some View {
        ZStack{
            WebView(url: viewModel.article.url!)
                .sheet(isPresented: $showShareSheet, content: {
                    ShareSheet(activityItems: [URL(string: viewModel.article.url ?? "") as Any])
                })
            VStack{
                Spacer().layoutPriority(5)
                HStack{
                    Spacer().layoutPriority(5)
                    FloatingButton(
                        mainButtonView: AnyView(MainButton(imageName: "ellipsis", color: .accentColor)),
                        buttons: [
                            AnyView(IconAndTextButton(
                                        imageName: viewModel.isBookmarked
                                            ? "bookmark.fill"
                                            : "bookmark",
                                        buttonText: "Add to bookmarks")
                                        .onTapGesture {
                                            viewModel.isBookmarked
                                                ? viewModel.deleteBookmark()
                                                : viewModel.addBookmark()
                                        }
                            ),
                            AnyView(IconAndTextButton(
                                        imageName: "arrowshape.turn.up.left.fill",
                                        buttonText: "Share a link")
                                        .onTapGesture {
                                            showShareSheet = true
                                        }
                            ),
                            AnyView(
                                NavigationLink(
                                    destination: ArticleList(
                                        request: TopHeadlinesRequest(
                                            sources: [
                                                viewModel.article.source.id ??
                                                viewModel.article.source.name.lowercased().replacingOccurrences(of: " ", with: "-")
                                            ]
                                        ),
                                        title: viewModel.article.source.name
                                    )
                            ){
                                IconAndTextButton(
                                        imageName: "building.columns",
                                        buttonText: "News for the source")
                                }
                            )
                        ]
                    )
                    .straight()
                    .direction(.top)
                    .alignment(.right)
                    .spacing(20)
                    .initialOffset(x: 1000)
                    .animation(.spring())
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .topTrailing)
        .onAppear{viewModel.checkIfBookmark()}
        .navigationBarTitle(viewModel.article.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            HStack{
                Button(action: {
                    withAnimation{
                        viewModel.isBookmarked
                            ? viewModel.deleteBookmark()
                            : viewModel.addBookmark()
                    }
                }) {
                    Image(systemName: viewModel.isBookmarked
                        ? "bookmark.fill"
                        : "bookmark")
                }
                Button(action: {
                    showShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .padding(.leading)
                }
            }
        }
    }
}
