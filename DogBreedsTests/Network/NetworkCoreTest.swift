import Testing
import Foundation
@testable import DogBreeds

struct NetworkCoreImplTests {
    var networkCore: NetworkCoreImpl!
    var mockSession: MockSessionWrapper!
    let validEndpoint = EndpointMock(path: "test")
    let host = "https://example.com"
    
    init() {
        mockSession = MockSessionWrapper()
        networkCore = NetworkCoreImpl(session: mockSession, host: host)
    }

    @Test("get returns data when network request succeeds")
    func getSuccess() async throws {
        let expectedData = "Success".data(using: .utf8)!
        mockSession.mockData = expectedData
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "\(host)/valid")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = try await networkCore.get(endpoint: validEndpoint)

        #expect(data == expectedData)
    }

    @Test("get throws invalidResponse error when response is not HTTPURLResponse")
    func invalidResponse() async throws {
        mockSession.mockResponse = URLResponse()

        await #expect(throws: NetworkError.invalidResponse) {
            try await networkCore.get(endpoint: validEndpoint)
        }
    }

    @Test("get throws requestFailed error when status code is not 200")
    func not200StatusCode() async throws {
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "\(host)/valid")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        await #expect(throws: NetworkError.requestFailed(code: 404)) {
            try await networkCore.get(endpoint: validEndpoint)
        }
    }
}
