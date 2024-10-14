protocol BreedsRepository {
    func getBreeds() async throws -> [DogBreed]
    func getBreed(id: Int) async throws -> DogBreed
}

enum BreedsRepositoryError: Error {
    case networkError
    case configurationError
    case dataPersistenceError
}

struct BreedsRepositoryImpl: BreedsRepository {
    private let client: any NetworkClient<DogBreed>
    
    init(client: any NetworkClient<DogBreed>) {
        self.client = client
    }
    
    func getBreeds() async throws -> [DogBreed] {
        do {
            let breeds = try await client.fetchList()
            // TODO: store data
            return breeds
        } catch NetworkError.requestFailed(code: _) {
            throw BreedsRepositoryError.networkError
        } catch {
            throw error
        }
    }
    
    func getBreed(id: Int) async throws -> DogBreed {
        do {
            let breed = try await client.fetch(by: id)
            // TODO: store data
            return breed
        } catch NetworkError.requestFailed(code: _) {
            throw BreedsRepositoryError.networkError
        } catch {
            throw error
        }
    }
}
