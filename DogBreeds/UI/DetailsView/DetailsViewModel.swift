import Foundation

final class DetailsViewModel: ObservableObject {
    @Published var breed: DogBreed?
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
}
