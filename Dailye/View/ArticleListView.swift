import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel: ArtitcleListViewModel
    var body: some View {
        Text("Status: \(viewModel.response?.status ?? "still")")
            .onAppear { self.viewModel.loadIfNeeded() }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(viewModel: ArtitcleListViewModel())
    }
}
