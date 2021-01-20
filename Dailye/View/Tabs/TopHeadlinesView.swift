import SwiftUI

struct TopHeadlinesView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Categories.allCases.indices) {index in
                                NavigationLink(destination: ArticleList(
                                                request: TopHeadlinesRequest(category: Categories.allCases[index]),
                                                title: Categories.allCases[index].rawValue)){
                                    CategoryTagView(category: Categories.allCases[index])
                                }
                            }
                        }.padding()
                    }
                    ArticleList(request: TopHeadlinesRequest(country: Countries.unitedStates))
                }
            }
            .navigationBarTitle("Top headlines.")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadlinesView()
            .preferredColorScheme(.light)
    }
}
