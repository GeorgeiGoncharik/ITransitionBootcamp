import SwiftUI

struct ArticleListView: View {
    @StateObject var viewModel: ArticleListViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.articles){ article in
                        NavigationLink(destination: ArticleDetailView(article: article)){
                            ArticleView(article: article)
                        }
                    }
                }
                .onAppear { self.viewModel.loadIfNeeded() }
            }
            .navigationTitle("Articles")
            .overlay(StatusOverlayView(viewModel: viewModel))
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(viewModel: ArticleListViewModel())
    }
}
