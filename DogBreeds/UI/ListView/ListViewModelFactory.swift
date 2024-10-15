@MainActor
protocol ListViewModelFactory {
    func make() -> ListViewModel
}

struct ListViewModelFactoryImpl: ListViewModelFactory {
    private let navigation: () -> ListNavigationDelegate
    init(navigation: @escaping  @autoclosure () -> ListNavigationDelegate) {
        self.navigation = navigation
    }
    func make() -> ListViewModel {
        ListViewModel(navigationDelegate: navigation())
    }
}
