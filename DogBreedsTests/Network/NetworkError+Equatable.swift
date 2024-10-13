@testable import DogBreeds

extension NetworkError: @retroactive Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL): return true
        case (.invalidResponse, .invalidResponse): return true
        case (.requestFailed(let lhsCode), .requestFailed(code: let rhsCode)):
            return lhsCode == rhsCode
        default: return false
        }
    }
}
