import SwiftUI
import URLImage

struct ArticleRow: View {
    var article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
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
                                    .cornerRadius(cornerRadius)
                             })
                }
                Group{
                    if let title = article.title{
                        Text(title)
                            .font(.title3)
                            .cardText()
                    }
                    if let desc = article.articleDescription{
                        Text(desc)
                            .lineLimit(descriptionLineLimit)
                            .font(.subheadline)
                            .cardText()
                    }
                    HStack{
                        Text("\(article.source.name)・\(article.publishedAtText)")
                            .font(.footnote)
                        
                        Spacer()
                        
                        Group{
                            Button(action: {
                                print("bookmark button was tapped")
                            }) {
                                Image(systemName: "bookmark")
                            }
                            Button(action: {
                                print("share button was tapped")
                            }) {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                        .padding(.horizontal)
                        .font(.headline)
                    }
                    .padding(.bottom)
                }
                .padding(.horizontal)
        }
            .cardLook()
    }
    
    //MARK: - Constants
    let cornerRadius: CGFloat = 25
    let shadowRadius: CGFloat = 4
    let descriptionLineLimit: Int = 2
    let smallPadding: CGFloat = 1
    let footLineLimit: Int = 1
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: Article(source: Source(id: "cnn", name: "CNN"),
                                     author: "Clare Foran, Ted Barrett and Ali Zaslav, CNN",
                                     title: "Senate votes to override Trump's veto on defense bill - CNN",
                                     articleDescription: "The Senate voted on Friday to override President Donald Trump's veto of the sweeping defense bill known as the National Defense Authorization Act, delivering a bipartisan rebuke to the President in his final days in office.",
                                     url: "https://www.cnn.com/2021/01/01/politics/senate-votes-to-override-trump-veto-ndaa/index.html",
                                     urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/201222195207-capitol-file-super-tease.jpg",
                                     publishedAt: nil,
                                     content: nil))
    }
}
