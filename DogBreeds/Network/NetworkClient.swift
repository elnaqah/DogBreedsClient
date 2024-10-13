protocol NetworkClient<Model> {
    associatedtype Model: Decodable
    func fetchList() async throws -> [Model]
    func fetch(by id: Int) async throws -> Model
}
