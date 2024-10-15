@MainActor
protocol Router: Sendable {
    func push(screen: Screen)
    func pop()
}

struct RouterImpl: Router {
    private let screenProvider: ScreenProvider
    private let screenMapper: ScreenMapper
    
    init(
        screenProvider: ScreenProvider,
        screenMapper: ScreenMapper
    ) {
        self.screenProvider = screenProvider
        self.screenMapper = screenMapper
    }
    
    func push(screen: Screen) {
        let screenViewModel = screenMapper.map(screen: screen)
        screenProvider.push(screen: screenViewModel)
    }

    func pop() {
        screenProvider.pop()
    }
}

