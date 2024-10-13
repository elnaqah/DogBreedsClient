import Foundation
@testable import DogBreeds

class MockSessionWrapper: SessionWrapper {
    var mockData: Data?
    var mockError: Error?
    var mockResponse: URLResponse?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        
        let response = mockResponse ?? HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = mockData ?? Data()
        
        return (data, response)
    }
}
