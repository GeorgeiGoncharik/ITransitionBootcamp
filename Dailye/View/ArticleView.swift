import SwiftUI

struct ArticleView: View {
    var article: Article
    var body: some View {
        VStack(alignment: .leading){
            Text(article.title ?? "")
                .font(.title2)
                .foregroundColor(.primary)
                .lineLimit(2)
            Group{
                HStack(){
                    Text(article.author ?? "")
                        .lineLimit(1)
                    Spacer()
                    Text(article.source.name)
                }
                Text(article.publishedAt != nil
                        ? "Published at \(article.publishedAt!.description)"
                        : "")
            }
                .font(.subheadline)
                .foregroundColor(.secondary)
            //Divider()
            Text(article.articleDescription ?? "")
        }
            .padding()
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article(source: Source(id: "cnn", name: "CNN"),
                                     author: "Clare Foran, Ted Barrett and Ali Zaslav, CNN",
                                     title: "Senate votes to override Trump's veto on defense bill - CNN",
                                     articleDescription: "The Senate voted on Friday to override President Donald Trump's veto of the sweeping defense bill known as the National Defense Authorization Act, delivering a bipartisan rebuke to the President in his final days in office.",
                                     url: "https://www.cnn.com/2021/01/01/politics/senate-votes-to-override-trump-veto-ndaa/index.html",
                                     urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/201222195207-capitol-file-super-tease.jpg",
                                     publishedAt: nil,
                                     content: nil))
    }
}
