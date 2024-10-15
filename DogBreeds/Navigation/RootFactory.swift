@MainActor
protocol RootFactory {
    func make() -> ScreenViewModel
}

struct RootFactoryImpl: RootFactory {
    private let listViewModelFactory: ListViewModelFactory
    
    init(listViewModelFactory: ListViewModelFactory) {
        self.listViewModelFactory = listViewModelFactory
    }
    
    func make() -> ScreenViewModel {
        .list(listViewModelFactory.make())
    }
}
