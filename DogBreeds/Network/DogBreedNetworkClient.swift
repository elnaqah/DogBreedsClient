import Foundation

struct DogBreedNetworkClient: NetworkClient {
    private let networkCore: NetworkCore
    
    init(networkCore: NetworkCore) {
        self.networkCore = networkCore
    }
    
    func fetchList() async throws(NetworkError) -> [DogBreed] {
        let data = try await networkCore.get(endpoint: BreedsEndpoint.breeds)
        
        let decoder = JSONDecoder()
        do {
            let breeds = try decoder.decode([DogBreed].self, from: data)
            return breeds
        } catch {
            throw .decodeError
        }
    }
    
    func fetch(by id: Int) async throws(NetworkError) -> DogBreed {
        let data = try await networkCore.get(endpoint: BreedsEndpoint.breeds)
        
        let decoder = JSONDecoder()
        do {
            let dogBread = try decoder.decode(DogBreed.self, from: data)
            return dogBread
        } catch {
            throw .decodeError
        }
    }
}
