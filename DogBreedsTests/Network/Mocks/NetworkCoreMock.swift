import Foundation
@testable import DogBreeds

class NetworkCoreMock: NetworkCore {
    var mockData: Data?
    var mockError: Error?
    
    func get(endpoint: Endpoint) async throws -> Data {
        if let error = mockError {
            throw error
        }
        
        return mockData ?? Data()
    }
}
