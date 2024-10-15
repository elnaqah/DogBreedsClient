@MainActor
protocol ScreenMapper {
    func map(screen: Screen) -> ScreenViewModel
    func map(screenViewModel: ScreenViewModel) -> Screen
}

struct ScreenMapperImpl: ScreenMapper {
    private let listViewModelFactory: ListViewModelFactory
    private let detailsViewModelFactory: DetailsViewModelFactory
    
    init(listViewModelFactory: ListViewModelFactory, detailsViewModelFactory: DetailsViewModelFactory) {
        self.listViewModelFactory = listViewModelFactory
        self.detailsViewModelFactory = detailsViewModelFactory
    }
    
    func map(screen: Screen) -> ScreenViewModel {
        switch screen {
        case .loading:
            return .loading
        case .list:
            let viewModel = listViewModelFactory.make()
            return .list(viewModel)
        case .detail(id: let id):
            let viewModel = detailsViewModelFactory.make(with: id)
            return .detail(viewModel)
        }
    }
    
    func map(screenViewModel: ScreenViewModel) -> Screen {
        switch screenViewModel {
        case .loading:
            return .loading
        case .list:
            return .list
        case .detail(let viewModel):
            return .detail(id: viewModel.id)
        }
    }
}
