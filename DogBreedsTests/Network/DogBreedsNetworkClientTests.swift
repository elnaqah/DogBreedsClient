import Foundation
import Testing
@testable import DogBreeds

struct BreedsNetworkClientTests {
    
    private let client: DogBreedNetworkClient!
    private let networkCore: NetworkCoreMock!
    
    init() {
        self.networkCore = NetworkCoreMock()
        self.client = DogBreedNetworkClient(networkCore: networkCore)
    }

    @Test("Lists decode and return a list of breeds")
    func breedList() async throws {
        let breeds = [DogBreed(id: 1, name: "Test", size: "Large")]
        let breedsData = try JSONEncoder().encode(breeds)
        networkCore.mockData = breedsData
        let response = try await client.fetchList()
        #expect(response.count > 0)
    }
    
    @Test("Get breed decode and returns a breed")
    func breed() async throws {
        let breed = DogBreed(id: 1, name: "Golden Retriever", size: "Large")
        let breedData = try JSONEncoder().encode(breed)
        networkCore.mockData = breedData
        let response = try await client.fetch(by: 1)
        #expect(response.name == breed.name)
    }
}
