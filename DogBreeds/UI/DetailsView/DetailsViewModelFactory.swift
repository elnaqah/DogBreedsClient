@MainActor
protocol DetailsViewModelFactory {
    func make(with id: Int) -> DetailsViewModel
}

struct DetailsViewModelFactoryImpl: DetailsViewModelFactory {
    func make(with id: Int) -> DetailsViewModel {
        DetailsViewModel(id: id)
    }
}
