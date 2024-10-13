import Testing
@testable import DogBreeds

@Suite
struct BreedsNetworkClientTests {
    
    private let client = DogBreedNetworkClient()

    @Test("Lists return a list of breeds")
    func breedList() async throws {
        let response = try await client.fetchList()
        #expect(response.count > 0)
    }
    
    @Test("Get breed returns a breed")
    func breed() async throws {
        let response = try await client.fetch(by: 1)
        #expect(response.name == "Golden Retriever")
    }
}
