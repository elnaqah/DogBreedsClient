import Foundation

@MainActor
final class ListViewModel: ObservableObject, Sendable {
    @Published var breeds: [DogBreed]
    @Published var isLoading: Bool = false
    private let navigationDelegate: ListNavigationDelegate
    private let repository: BreedsRepository
    
    init(
        initialBreeds: [DogBreed] = [],
        navigationDelegate: ListNavigationDelegate,
        repository: BreedsRepository
    ) {
        self.breeds = initialBreeds
        self.navigationDelegate = navigationDelegate
        self.repository = repository
    }
    
    func fetchBreeds() async {
        isLoading = true
        defer { isLoading = false }
        do {
            breeds = try await repository.getBreeds()
        } catch {
            // TODO: handle error
        }
    }
    
    func openDetails(for breed: DogBreed) {
        navigationDelegate.openDetails(id: breed.id)
    }
}
