import Foundation
protocol SessionWrapper: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

struct SessionWrapperImpl: SessionWrapper {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}
