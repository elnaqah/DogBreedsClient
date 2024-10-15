import Foundation

@MainActor
final class ScreenProvider: ObservableObject {
    @Published var screenViewModels = [ScreenViewModel]() {
        didSet {
            updateScreens()
        }
    }
    @Published var root: ScreenViewModel
    @Published var screens = [Screen]() {
        didSet {
            if screens.count < screenViewModels.count {
                pop()
            }
        }
    }
    let mapper: ScreenMapper
    
    init(mapper: ScreenMapper, rootFactory: RootFactory) {
        self.mapper = mapper
        self.root = rootFactory.make()
    }
    
    func push(screen: ScreenViewModel) {
        screenViewModels.append(screen)
    }
    
    func pop() {
        screenViewModels.removeLast()
    }
    
    func getScreenViewModel(for screen: Screen) -> ScreenViewModel {
        guard let index = screens.firstIndex(of: screen) else {
            return root
        }
        return screenViewModels[index]
    }
    
    private func updateScreens() {
        screens = screenViewModels.map(mapper.map)
    }
}
