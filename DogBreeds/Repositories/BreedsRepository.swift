protocol BreedsRepository: Sendable {
    func getBreeds() async throws(BreedsRepositoryError) -> [DogBreed]
    func getBreed(id: Int) async throws(BreedsRepositoryError) -> DogBreed
}

enum BreedsRepositoryError: Error {
    case network
    case dataPersistence
    case cacheNotFound
    case unknown
}

struct BreedsRepositoryImpl: BreedsRepository {
    private let client: NetworkClient
    private let localRepository: LocalRepository
    private let connectivity: ConnectivityMonitor
    
    init(
        client: NetworkClient,
        localRepository: LocalRepository,
        connectivity: ConnectivityMonitor
    ) {
        self.client = client
        self.localRepository = localRepository
        self.connectivity = connectivity
    }
    
    func getBreeds() async throws(BreedsRepositoryError) -> [DogBreed] {
        do {
            guard await connectivity.isConnected else {
                return try await localRepository.getAll()
            }
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
            guard await connectivity.isConnected else {
                return try await getCachedBreed(with: id)
            }
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
    
    private func getCachedBreed(with id: Int) async throws -> DogBreed {
        guard let breed = try await localRepository.get(id: id) else {
            throw BreedsRepositoryError.cacheNotFound
        }
        
        return breed
    }
    
    private func updateBreeds(breeds: [DogBreed]) async throws {
        try await localRepository.upsert(breeds: breeds)
    }
}
