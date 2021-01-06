import SwiftUI

struct ArticleListView: View {
    @StateObject var viewModel: ArtitcleListViewModel
    
    var body: some View {
        NavigationView{
            List(viewModel.articles){ article in
                NavigationLink(destination: ArticleDetailView(article: article)){
                    ArticleView(article: article)
                }
            }
                .navigationTitle("Articles")
                .overlay(StatusOverlayView(viewModel: viewModel))
                .onAppear { self.viewModel.loadIfNeeded() }
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(viewModel: ArtitcleListViewModel())
    }
}
