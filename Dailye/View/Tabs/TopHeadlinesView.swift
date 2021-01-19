import SwiftUI

struct TopHeadlinesView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Categories.allCases.indices) {index in
                                NavigationLink(destination: ArticleList(request: TopHeadlinesRequest(category: Categories.allCases[index]))){
                                    CategoryTagView(category: Categories.allCases[index])
                                }
                            }
                        }.padding()
                    }
                    ArticleList()
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
