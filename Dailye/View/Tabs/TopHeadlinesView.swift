import SwiftUI

struct TopHeadlinesView: View {
    @StateObject private var viewModel = TopHeadlinesViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    categoriesTabs
                    ArticleList(
                        request: TopHeadlinesRequest(
                            language: viewModel.language,
                            country: viewModel.country
                        )
                    )
                }
            }
            .navigationBarTitle("Top headlines.")
        }
    }
    
    var categoriesTabs: some View{
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Categories.allCases.indices) {index in
                    NavigationLink(
                        destination: ArticleList(
                            request: TopHeadlinesRequest(
                                category: Categories.allCases[index],
                                language: viewModel.language,
                                country: viewModel.country
                            ),
                            title: Categories.allCases[index].rawValue
                        )
                    ){
                        CategoryTagView(
                            category: Categories.allCases[index]
                        )
                    }
                }
            }.padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadlinesView()
            .preferredColorScheme(.light)
    }
}
