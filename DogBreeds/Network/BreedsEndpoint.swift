enum BreedsEndpoint: Endpoint {
    case breeds
    case breed(id: String)
    
    var path: String {
        switch self {
        case .breeds: return "breeds"
        case .breed(let id): return "breeds/\(id)"
        }
    }
}
