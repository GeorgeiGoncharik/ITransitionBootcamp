import SwiftUI
import CoreData

struct BookmarkListView: View {
    @StateObject private var viewModel = BookmarkListViewModel()
    
    var body: some View {
        NavigationView{
            Group{
                if viewModel.bookmarks.isEmpty{
                    VStack{
                        Image("empty-folder")
                            .scaledToFit()
                        Text("You don't have any yet.")
                    }
                } else{
                    ScrollView{
                        LazyVStack {
                            ForEach(viewModel.bookmarks){ bookmark in
                                NavigationLink(destination: BookmarkDetail(bookmark)){
                                    BookmarkRow(bookmark: bookmark)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .onAppear{viewModel.fetchBookmarks()}
            .navigationTitle("Bookmarks")
        }
    }
}
