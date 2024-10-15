struct ListNavigationDelegateImpl: ListNavigationDelegate {
    private let router: () -> Router
    
    init(router: @autoclosure @escaping () -> Router) {
        self.router = router
    }
    
    func openDetails(id: Int) {
        router().push(screen: .detail(id: id))
    }
}
