import SwiftUI
import URLImage

struct ArticleRow: View {
    @StateObject private var viewModel: ArticleSharedViewModel
    @State private var showShareSheet = false
    
    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleSharedViewModel(article: article))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            if let urlToImage = viewModel.article.urlToImage, let url = URL(string: urlToImage){
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
                    
                if let title = viewModel.article.title{
                        Title(title, with: .horizontal)
                    }
                } else {
                    if let title = viewModel.article.title{
                        Title(title, with: [.horizontal, .top])
                    }
                }
                Group{
                    if let desc = viewModel.article.articleDescription{
                        Text(desc)
                            .lineLimit(descriptionLineLimit)
                            .font(.subheadline)
                            .cardText()
                    }
                    HStack{
                        Text("\(viewModel.article.source.name)・\(viewModel.article.publishedAt.withAgo)")
                            .font(.footnote)
                            .lineLimit(footLineLimit)
                        
                        Spacer()
                        
                        Group{
                            Button(action: {
                                withAnimation{
                                    viewModel.isBookmarked
                                        ? viewModel.deleteBookmark()
                                        : viewModel.addBookmark()
                                }
                            }) {
                                Image(systemName: viewModel.isBookmarked
                                    ? "bookmark.fill"
                                    : "bookmark")
                            }
                            .animation(.easeInOut)
                            Button(action: {
                                showShareSheet = true
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
        .sheet(isPresented: $showShareSheet, content: {
            ShareSheet(activityItems: [URL(string: viewModel.article.url ?? "") as Any])
        })
        .onAppear{viewModel.checkIfBookmark()}
        .cardText()
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
