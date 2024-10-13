struct DogBreedNetworkClient: NetworkClient {
    func fetchList() async throws -> [DogBreed] {
        return []
    }
    
    func fetch(by id: Int) async throws -> DogBreed {
        return DogBreed(id: "", name: "", size: "")
    }
}
