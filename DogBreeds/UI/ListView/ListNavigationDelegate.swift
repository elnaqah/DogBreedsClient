@MainActor
protocol ListNavigationDelegate: Sendable {
    func openDetails(id: Int)
}
