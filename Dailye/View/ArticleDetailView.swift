import SwiftUI
import URLImage

struct ArticleDetailView: View {
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
                                .ignoresSafeArea(edges: .top)
                          })
                }
            VStack(alignment: .leading) {
                if let title = article.title{
                    Text(title)
                        .font(.title)
                        .foregroundColor(.primary)
                }
                HStack {
                    if let author = article.author{
                        Text(author)
                    }
                    Spacer()
                    Text(article.source.name)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()
                    
                if let desc = article.articleDescription{
                    Text(desc)
                }
                
                Button("Read more →") {
                    
                }
            }
                .padding()
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: Article(source: Source(id: "cnn", name: "CNN"),
                                           author: "Clare Foran, Ted Barrett and Ali Zaslav, CNN",
                                           title: "Senate votes to override Trump's veto on defense bill - CNN",
                                           articleDescription: "The Senate voted on Friday to override President Donald Trump's veto of the sweeping defense bill known as the National Defense Authorization Act, delivering a bipartisan rebuke to the President in his final days in office.",
                                           url: "https://www.cnn.com/2021/01/01/politics/senate-votes-to-override-trump-veto-ndaa/index.html",
                                           urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/201222195207-capitol-file-super-tease.jpg",
                                           publishedAt: nil,
                                           content: nil))
    }
}
