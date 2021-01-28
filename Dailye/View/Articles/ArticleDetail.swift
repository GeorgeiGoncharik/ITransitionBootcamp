import SwiftUI
import URLImage

struct ArticleDetail: View {
    @StateObject private var viewModel: ArticleSharedViewModel
    
    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleSharedViewModel(article: article))
    }
    
    var body: some View {
        WebView(url: viewModel.article.url!)
            .onAppear{viewModel.checkIfBookmark()}
            .navigationBarTitle(viewModel.article.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
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
                            .imageScale(.large)
                    }
                    Button(action: {
                        
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .imageScale(.large)
                    }
                }
            )
    }
}
