import SwiftUI

struct AppView: View {
    var body: some View {
        TabView{
            TopHeadlinesView()
                .tabItem {
                    Image(systemName: "flame")
                    Text("Top headlines")
                }
            SearchView(viewModel: SearchViewModel())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            BookmarkListView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Bookmarks")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
