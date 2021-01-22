import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                CardTextField(
                    textField: TextField("", text: $viewModel.search),
                    imageName: "magnifyingglass"
                )
                .padding()
                
                ScrollView{
                    LazyVStack {
                        ForEach(viewModel.articles){ article in
                            NavigationLink(destination: ArticleDetail(article: article)){
                                ArticleRow(article: article)
                            }
                        }.padding()
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}

private extension SearchView{
    var allNewsSection: some View {
        return
            ArticleList(
                request: EverythingRequest(
                    sortingStrategy: .popularity,
                    pageSize: 100
                )
            )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
