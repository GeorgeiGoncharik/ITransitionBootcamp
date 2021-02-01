import SwiftUI

struct AppView: View {
    @State private var isNOTShowingOnboarding = UserDefaults
        .standard
        .bool(forKey: Defaults.onboarding)
    
    var body: some View {
        
        if isNOTShowingOnboarding{
            applicationTabs
        }
        else{
            onboardingTabs
        }
    }
    
    private var applicationTabs: some View{
        TabView{
            TopHeadlinesView()
                .tabItem {
                    Image(systemName: "flame")
                    Text("Top headlines")
                }
            SearchView()
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
    
    private var onboardingTabs: some View{
        TabView{
            OnboardingView(image: "share", title: "Share", desc: "Share the news with your friends and family to keep them informed")
            OnboardingView(image: "keep", title: "Keep", desc: "Save the news you like in your bookmarks and easily find them at any time")
            
            VStack{
                OnboardingView(image: "note", title: "Note", desc: "Leave your thoughts and ideas when you feel like it")
                Button(action: doneButtonPressed, label: {
                    Text("Get started")
                        .padding()
                        .cardLook()
                        .padding()
                })
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(
            PageIndexViewStyle(
                backgroundDisplayMode: .always
            )
        )
    }
    
    private func doneButtonPressed(){
        isNOTShowingOnboarding = true
        UserDefaults
            .standard
            .set(isNOTShowingOnboarding, forKey: Defaults.onboarding)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
