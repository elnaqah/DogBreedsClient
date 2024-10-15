protocol Composer {
    associatedtype Component
    static func compose() -> Component
}

@MainActor
protocol MainComposer {
    associatedtype UIComponent
    static func compose() -> UIComponent
}
