protocol NetworkClient: Sendable {
    func fetchList() async throws(NetworkError) -> [DogBreed]
    func fetch(by id: Int) async throws(NetworkError) -> DogBreed
}
