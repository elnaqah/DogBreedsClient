import SwiftUI

struct RouterView: View {
    @ObservedObject var screenProvider: ScreenProvider
    init(screenProvider: ScreenProvider, screenMapper: ScreenMapper) {
        self.screenProvider = screenProvider
    }
    var body: some View {
        NavigationStack(path: $screenProvider.screens) {
            selectedView(screen: screenProvider.root)
                .navigationDestination(for: Screen.self) { screen in
                let screenViewModel = screenProvider.getScreenViewModel(for: screen)
                selectedView(screen: screenViewModel)
            }
        }
    }
    
    @ViewBuilder
    func selectedView(screen: ScreenViewModel) -> some View {
        switch screen {
        case .loading:
            ProgressView()
        case .list(let viewModel):
            ListView(viewModel: viewModel)
        case .detail(let viewModel):
            DetailsView(viewModel: viewModel)
        }
    }
}
