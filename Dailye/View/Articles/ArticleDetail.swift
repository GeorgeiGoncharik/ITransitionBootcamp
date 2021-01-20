import SwiftUI
import URLImage

struct ArticleDetail: View {
    var article: Article
    var body: some View {
        ScrollView{
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage){
                URLImage(url: url,
                         empty: { EmptyView() },
                         inProgress: { _ in EmptyView() },
                         failure: { _, _ in Text("Downloading has failed!")
                         },
                         content: { image, _ in
                             image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(25)
                          })
                }
            VStack(alignment: .leading) {
                if let title = article.title{
                    Text(title)
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                        .cardText()
                }
                HStack {
                    NavigationLink(
                        destination: ArticleList(
                            request: TopHeadlinesRequest(
                                sources:
                                    [
                                        article.source.id ??
                                        article.source.name.lowercased().replacingOccurrences(of: " ", with: "-")
                                    ]),
                            title: article.source.name)){
                        Text(article.source.name)
                            .cardText()
                        }
                    Spacer()
                    if let author = article.author{
                        Text(author)
                            .cardText()
                    }
                }
                .font(.subheadline)

                Divider()
                    
                if let desc = article.articleDescription{
                    Text(desc)
                        .cardText()
                }
                
                Spacer()
                
                NavigationLink(destination: WebView(url: article.url!)){
                        Text("Read more →")
                }
            }
        }
        .padding()
        .navigationBarTitle("Read about it.")
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(article: Article(source: Source(id: "cnn", name: "CNN"),
                                           author: "Clare Foran, Ted Barrett and Ali Zaslav, CNN",
                                           title: "Senate votes to override Trump's veto on defense bill - CNN",
                                           articleDescription: "The Senate voted on Friday to override President Donald Trump's veto of the sweeping defense bill known as the National Defense Authorization Act, delivering a bipartisan rebuke to the President in his final days in office.",
                                           url: "https://www.cnn.com/2021/01/01/politics/senate-votes-to-override-trump-veto-ndaa/index.html",
                                           urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/201222195207-capitol-file-super-tease.jpg",
                                           publishedAt: nil,
                                           content: nil))
    }
}
