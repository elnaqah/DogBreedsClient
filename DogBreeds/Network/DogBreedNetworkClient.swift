import Foundation

struct DogBreedNetworkClient: NetworkClient {
    private let networkCore: NetworkCore
    
    init(networkCore: NetworkCore) {
        self.networkCore = networkCore
    }
    
    func fetchList() async throws -> [DogBreed] {
        let data = try await networkCore.get(endpoint: BreedsEndpoint.breeds)
        
        let decoder = JSONDecoder()
        let breeds = try decoder.decode([DogBreed].self, from: data)
        
        return breeds
    }
    
    func fetch(by id: Int) async throws -> DogBreed {
        let data = try await networkCore.get(endpoint: BreedsEndpoint.breeds)
        
        let decoder = JSONDecoder()
        let dogBread = try decoder.decode(DogBreed.self, from: data)
        
        return dogBread
    }
}
