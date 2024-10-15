import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(code: Int)
    case serverError
    case decodeError
}

protocol NetworkCore {
    func get(endpoint: Endpoint) async throws(NetworkError) -> Data
}

struct NetworkCoreImpl: NetworkCore {
    private let session: SessionWrapper
    private let host: String
    
    init(
        session: SessionWrapper,
        host: String = ""
    ) {
        self.session = session
        self.host = host
    }
    
    func get(endpoint: Endpoint) async throws(NetworkError) -> Data {
        guard let url = URL(string: "\(host)/\(endpoint.path)") else {
            throw NetworkError.invalidURL
        }
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
                
            guard response.statusCode == 200 else {
                throw NetworkError.requestFailed(code: response.statusCode)
            }
            
            return data
        } catch {
            throw NetworkError.serverError
        }
    }
}
