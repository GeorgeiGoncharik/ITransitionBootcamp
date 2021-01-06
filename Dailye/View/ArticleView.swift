import SwiftUI
import URLImage

struct ArticleView: View {
    var article: Article
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .foregroundColor(.white)
                .shadow(radius: shadowRadius)
            VStack(alignment: .leading){
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
                            .foregroundColor(.primary)
                    }
                    if let desc = article.articleDescription{
                        Text(desc)
                            .lineLimit(descriptionLineLimit)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    HStack{
                        if let published = article.publishedAt, let passed = Date() - published{
                            if let hours = passed.hour, hours < 48 {
                                Text("\(article.source.name)・\(hours) hours ago")
                            } else {
                                if let days = passed.day{
                                    Text("\(article.source.name)・\(days) days ago")
                                }
                            }
                        }
                        Spacer()
                    }
                    .lineLimit(footLineLimit)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                }
                .padding(.horizontal)
                .padding(.vertical, smallPadding)
            }
        }
        .padding()
    }
    
    //MARK: - Constants
    let cornerRadius: CGFloat = 6
    let shadowRadius: CGFloat = 4
    let descriptionLineLimit: Int = 2
    let smallPadding: CGFloat = 1
    let footLineLimit: Int = 1
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
