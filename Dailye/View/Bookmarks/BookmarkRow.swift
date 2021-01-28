import SwiftUI
import URLImage

struct BookmarkRow: View {
    var bookmark: Bookmark
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
                if let urlToImage = bookmark.urlToImage, let url = URL(string: urlToImage){
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
                    
                    if let title = bookmark.title{
                        Title(title, with: .horizontal)
                    }
                    
                } else {
                    
                    if let title = bookmark.title{
                        Title(title, with: [.horizontal, .top])
                    }
                }
                Group{
                    if let desc = bookmark.bookmarkDescription{
                        Text(desc)
                            .lineLimit(descriptionLineLimit)
                            .font(.subheadline)
                            .cardText()
                    }
                    HStack{
                        Text("\(bookmark.sourceName ?? "")・\(bookmark.publishedAt.withAgo)")
                            .font(.footnote)
                            .lineLimit(footLineLimit)
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.bottom)
                }
                .padding(.horizontal)
        }
            .cardLook()
    }
    
    func Title(_ title: String, with edges: Edge.Set) -> some View{
        Text(title)
            .padding(edges)
            .font(.title3)
            .cardText()
    }
    
    //MARK: - Constants
    let cornerRadius: CGFloat = 25
    let shadowRadius: CGFloat = 4
    let descriptionLineLimit: Int = 2
    let smallPadding: CGFloat = 1
    let footLineLimit: Int = 1
}
