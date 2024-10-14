protocol NetworkClient<Model> {
    associatedtype Model: Decodable
    func fetchList() async throws(NetworkError) -> [Model]
    func fetch(by id: Int) async throws(NetworkError) -> Model
}
