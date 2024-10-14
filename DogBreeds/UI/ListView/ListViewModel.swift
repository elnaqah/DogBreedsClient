import Foundation

@MainActor
final class ListViewModel: ObservableObject, Sendable {
    @Published var breeds: [DogBreed]
    private let navigationDelegate: ListNavigationDelegate
    
    init(
        initialBreeds: [DogBreed] = [],
        navigationDelegate: ListNavigationDelegate
    ) {
        self.breeds = initialBreeds
        self.navigationDelegate = navigationDelegate
    }
    
    func fetchBreeds() async {}
    
    func openDetails(for breed: DogBreed) {
        navigationDelegate.openDetails(id: breed.id)
    }
}
