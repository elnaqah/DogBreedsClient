import Foundation
@MainActor
final class DetailsViewModel: ObservableObject {
    @Published var breed: DogBreed?
    @Published var errorMessage: String?
    @Published var isLoading = false
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
        errorMessage = nil
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            breed = try await breedsRepository.getBreed(id: id)
        } catch {
            errorMessage = "Failed to get breed details"
        }
    }
}
