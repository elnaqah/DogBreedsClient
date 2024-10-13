struct DogBreed: Codable {
    let id: Int
    let name: String
    let size: String
    
    // Optional breed details
    let lifeExpectancy: String?
    let temperament: String?
    let origin: String?
    let activityLevel: String?
}
