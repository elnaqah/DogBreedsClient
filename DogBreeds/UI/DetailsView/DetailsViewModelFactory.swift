@MainActor
protocol DetailsViewModelFactory {
    func make(with id: Int) -> DetailsViewModel
}

struct DetailsViewModelFactoryImpl: DetailsViewModelFactory {
    private let breedsRepository: BreedsRepository
    
    init(breedsRepository: BreedsRepository) {
        self.breedsRepository = breedsRepository
    }
    
    func make(with id: Int) -> DetailsViewModel {
        DetailsViewModel(id: id, breedsRepository: breedsRepository)
    }
}
