import SwiftUI
import CoreData

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                CardTextField(
                    textField: TextField("", text: $viewModel.search),
                    imageName: "magnifyingglass"
                )
                .padding()
                
                LazyVStack {
                    ForEach(viewModel.articles, id: \.self){ article in
                        NavigationLink(destination: ArticleDetail(article: article)){
                            ArticleRow(article: article)
                        }
                    }.padding()
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
