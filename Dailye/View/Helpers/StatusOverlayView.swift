import SwiftUI

struct StatusOverlayView: View {

    @ObservedObject var viewModel: ArticleListViewModel

    var body: some View {
        switch viewModel.state {
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(EmptyView())
        case .loaded:
            return AnyView(EmptyView())
        case let .error(error):
            return AnyView(
                VStack(spacing: 10) {
                    Text(error.localizedDescription)
                        .frame(maxWidth: 300)
                    Button("Retry") {
                        self.viewModel.load()
                    }
                }
                .padding()
                .background(Color.yellow)
            )
        case .done:
            return AnyView(EmptyView())
        }
    }

}
