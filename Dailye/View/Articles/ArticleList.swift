import SwiftUI

struct ArticleList: View {
    @StateObject var viewModel: ArticleListViewModel
    
    init(request: Requestable = TopHeadlinesRequest(country: Countries.unitedStates)) { // bogus
        _viewModel = StateObject(wrappedValue: ArticleListViewModel(request: request))
    }
    
    var body: some View {
        ScrollView{
            LazyVStack {
                
                ForEach(viewModel.articles){ article in
                    NavigationLink(destination: ArticleDetail(article: article)){
                        ArticleRow(article: article)
                    }
                }.padding()
            }
            .onAppear { self.viewModel.loadIfNeeded() }
            
            switch viewModel.state {
            case .loaded:
                Button("show more"){
                    self.viewModel.loadNextPage()
                }
                .padding()
                .cardLook()
                .padding()
            case .done:
                Text("Oops! That's all.")
                    .cardAccent()
                    .padding()
            case .ready:
                EmptyView()
            case .loading(_):
                AnyView(ProgressView())
                    .padding()
            case .error(_):
                EmptyView()
            }
        }
        .overlay(StatusOverlayView(viewModel: viewModel))
    }
}
