enum ScreenViewModel {
    case loading
    case list(ListViewModel)
    case detail(DetailsViewModel)
}

enum Screen: Hashable {
    case loading
    case list
    case detail(id: Int)
}
