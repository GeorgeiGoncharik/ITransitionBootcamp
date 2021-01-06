import SwiftUI

struct ArticleDetailView: View {
    var article: Article
    var body: some View {
        EmptyView()
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
