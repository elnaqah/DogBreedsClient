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
    
    func fetchBreeds() async {
        breeds = [
            DogBreed(id: 1, name: "Golden Retriever", size: "Large", lifeExpectancy: "10-12 years", temperament: "Friendly", origin: "Scotland", activityLevel: "High"),
            DogBreed(id: 2, name: "Beagle", size: "Medium", lifeExpectancy: "12-15 years", temperament: "Curious", origin: "England", activityLevel: "Medium"),
            DogBreed(id: 3, name: "Chihuahua", size: "Small", lifeExpectancy: "12-20 years", temperament: "Loyal", origin: "Mexico", activityLevel: "Low"),
            DogBreed(id: 4, name: "Great Dane", size: "Extra Large", lifeExpectancy: "7-10 years", temperament: "Gentle", origin: "Germany", activityLevel: "Moderate"),
            DogBreed(id: 5, name: "Bulldog", size: "Medium", lifeExpectancy: "8-12 years", temperament: "Docile", origin: "England", activityLevel: "Low")
        ]
    }
    
    func openDetails(for breed: DogBreed) {
        navigationDelegate.openDetails(id: breed.id)
    }
}
