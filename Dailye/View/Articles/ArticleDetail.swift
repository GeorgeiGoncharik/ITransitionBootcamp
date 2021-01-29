import SwiftUI
import URLImage

struct ArticleDetail: View {
    @StateObject private var viewModel: ArticleSharedViewModel
    @State private var showShareSheet = false
    
    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleSharedViewModel(article: article))
    }
    
    var body: some View {
        WebView(url: viewModel.article.url!)
            .sheet(isPresented: $showShareSheet, content: {
                ShareSheet(activityItems: [URL(string: viewModel.article.url ?? "")])
            })
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
