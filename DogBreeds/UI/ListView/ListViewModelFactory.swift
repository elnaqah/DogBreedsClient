@MainActor
protocol ListViewModelFactory {
    func make() -> ListViewModel
}

struct ListViewModelFactoryImpl: ListViewModelFactory {
    private let navigation: () -> ListNavigationDelegate
    private let breedsRepository: BreedsRepository
    init(
        navigation: @escaping  @autoclosure () -> ListNavigationDelegate,
        breedsRepository: BreedsRepository
    ) {
        self.navigation = navigation
        self.breedsRepository = breedsRepository
    }
    func make() -> ListViewModel {
        ListViewModel(navigationDelegate: navigation(), repository: breedsRepository)
    }
}
