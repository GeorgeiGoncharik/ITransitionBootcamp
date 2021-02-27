import SwiftUI

struct ArticleList: View {
    @State private var title: String
    @StateObject private var viewModel: ArticleListViewModel
    
    init(request: Requestable, title: String = "") {
        _viewModel = StateObject(wrappedValue: ArticleListViewModel(request: request))
        _title = State(wrappedValue: title)
    }
    
    var body: some View {
        if(!title.isEmpty){
            content
                .navigationTitle(title.capitalized)
                .navigationBarTitleDisplayMode(.large)
        } else {
            content
        }
    }
    
    private var content: some View{
        return ScrollView{
            LazyVStack {
                
                ForEach(viewModel.articles, id: \.self){ article in
                    NavigationLink(destination: ArticleDetail(article: article)){
                        ArticleRow(article: article)
                    }
                }.padding()
            }
            .onAppear { self.viewModel.loadIfNeeded() }
            
            switch viewModel.state {
            case .loaded:
                Button("show more"){
                    self.viewModel.loadMore()
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
