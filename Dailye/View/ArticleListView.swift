import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel: ArtitcleListViewModel
    var body: some View {
        List(viewModel.articles){ article in
            ArticleView(article: article)
        }
            .overlay(StatusOverlayView(viewModel: viewModel))
            .onAppear { self.viewModel.loadIfNeeded() }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(viewModel: ArtitcleListViewModel())
    }
}
