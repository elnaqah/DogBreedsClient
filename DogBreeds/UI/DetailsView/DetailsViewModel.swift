import Foundation
@MainActor
final class DetailsViewModel: ObservableObject {
    @Published var breed: DogBreed?
    let id: Int
    private let breedsRepository: BreedsRepository
    
    init(
        id: Int,
        breedsRepository: BreedsRepository
    ) {
        self.id = id
        self.breedsRepository = breedsRepository
    }
    
    func getBreedDetails() async {
        do {
            breed = try await breedsRepository.getBreed(id: id)
        } catch {
            //TODO: handle error
        }
    }
}
