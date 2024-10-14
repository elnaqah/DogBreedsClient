enum LocalRepositoryError: Error {
    case noData
    case invalidData
}

protocol LocalReadRepository {
    func getAll() async throws(LocalRepositoryError) -> [DogBreed]
    func get(id: Int) async throws(LocalRepositoryError) -> DogBreed?
}

protocol LocalWriteRepository {
    func update(breed: DogBreed) async throws(LocalRepositoryError)
    func insert(breeds: [DogBreed]) async throws(LocalRepositoryError)
    func deleteAll() async throws(LocalRepositoryError)
}

protocol LocalRepository: LocalReadRepository, LocalWriteRepository {}
