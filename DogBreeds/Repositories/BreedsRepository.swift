protocol BreedsRepository {
    func getBreeds() async throws(BreedsRepositoryError) -> [DogBreed]
    func getBreed(id: Int) async throws(BreedsRepositoryError) -> DogBreed
}

enum BreedsRepositoryError: Error {
    case network
    case dataPersistence
    case unknown
}

struct BreedsRepositoryImpl: BreedsRepository {
    private let client: NetworkClient
    private let localRepository: LocalWriteRepository
    
    init(
        client: NetworkClient,
        localRepository: LocalWriteRepository
    ) {
        self.client = client
        self.localRepository = localRepository
    }
    
    func getBreeds() async throws(BreedsRepositoryError) -> [DogBreed] {
        do {
            let breeds = try await client.fetchList()
            try await updateBreeds(breeds: breeds)
            return breeds
        } catch is NetworkError {
            throw BreedsRepositoryError.network
        } catch is LocalRepository {
            throw BreedsRepositoryError.dataPersistence
        } catch {
            throw BreedsRepositoryError.unknown
        }
    }
    
    func getBreed(id: Int) async throws(BreedsRepositoryError) -> DogBreed {
        do {
            let breed = try await client.fetch(by: id)
            try await localRepository.update(breed: breed)
            return breed
        } catch is NetworkError {
            throw BreedsRepositoryError.network
        } catch is LocalRepositoryError {
            throw BreedsRepositoryError.dataPersistence
        } catch {
            throw BreedsRepositoryError.unknown
        }
    }
    
    private func updateBreeds(breeds: [DogBreed]) async throws {
        try await localRepository.deleteAll()
        try await localRepository.insert(breeds: breeds)
    }
}
