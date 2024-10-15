import Foundation
let breeds = [
    DogBreed(id: 1, name: "Golden Retriever", size: "Large", lifeExpectancy: "10-12 years", temperament: "Friendly", origin: "Scotland", activityLevel: "High"),
    DogBreed(id: 2, name: "Beagle", size: "Medium", lifeExpectancy: "12-15 years", temperament: "Curious", origin: "England", activityLevel: "Medium"),
    DogBreed(id: 3, name: "Chihuahua", size: "Small", lifeExpectancy: "12-20 years", temperament: "Loyal", origin: "Mexico", activityLevel: "Low"),
    DogBreed(id: 4, name: "Great Dane", size: "Extra Large", lifeExpectancy: "7-10 years", temperament: "Gentle", origin: "Germany", activityLevel: "Moderate"),
    DogBreed(id: 5, name: "Bulldog", size: "Medium", lifeExpectancy: "8-12 years", temperament: "Docile", origin: "England", activityLevel: "Low")
]

final class DetailsViewModel: ObservableObject {
    @Published var breed: DogBreed?
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func getBreedDetails() {
        breed = breeds.first(where: { id == $0.id })
    }
}
