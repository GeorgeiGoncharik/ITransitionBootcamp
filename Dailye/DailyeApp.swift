import SwiftUI

@main
struct DailyeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            ArticleListView(viewModel: ArticleListViewModel())
        }
    }
}
