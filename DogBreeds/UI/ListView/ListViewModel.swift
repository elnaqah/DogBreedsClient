import Foundation

@MainActor
final class ListViewModel: ObservableObject, Sendable {
    @Published var breeds: [DogBreed]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
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
        errorMessage = nil
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            breeds = try await repository.getBreeds()
        } catch {
            errorMessage = "Failed to get breed list"
        }
    }
    
    func openDetails(for breed: DogBreed) {
        navigationDelegate.openDetails(id: breed.id)
    }
}
