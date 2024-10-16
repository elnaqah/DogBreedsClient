import SwiftData
import Foundation

@Model
final class Breed {
    @Attribute(.unique)
    var id: Int
    var name: String
    var size: String
    
    // Optional breed details
    var lifeExpectancy: String?
    var temperament: String?
    var origin: String?
    var activityLevel: String?
    
    init(
        id: Int,
        name: String,
        size: String,
        lifeExpectancy: String?,
        temperament: String?,
        origin: String?,
        activityLevel: String?
    ) {
        self.id = id
        self.name = name
        self.size = size
        self.lifeExpectancy = lifeExpectancy
        self.temperament = temperament
        self.origin = origin
        self.activityLevel = activityLevel
    }
}


enum LocalRepositoryError: Error {
    case noData
    case invalidData
    case saveFailed
}

protocol LocalReadRepository: Actor {
    func getAll() throws(LocalRepositoryError) -> [DogBreed]
    func get(id: Int) throws(LocalRepositoryError) -> DogBreed?
}

protocol LocalWriteRepository: Actor {
    func update(breed: DogBreed) async throws(LocalRepositoryError)
    func insert(breeds: [DogBreed]) async throws(LocalRepositoryError)
    func deleteAll() async throws(LocalRepositoryError)
    func upsert(breeds: [DogBreed]) async throws(LocalRepositoryError)
}

protocol LocalRepository: LocalReadRepository, LocalWriteRepository {}

actor LocalRepositoryImpl: LocalRepository {
    
    private let container: ModelContainer = {
        let schema = Schema([
            Breed.self,
        ])

        do {
            return try ModelContainer(for: schema)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    private lazy var context: ModelContext = {
        ModelContext(container)
    }()
    
    func getAll() throws(LocalRepositoryError) -> [DogBreed] {
        do {
            return try getBreeds().map(\.dogBreed)
        } catch {
            throw LocalRepositoryError.invalidData
        }
    }
    
    private func getBreeds() throws -> [Breed] {
        let descriptor = FetchDescriptor<Breed>()
        return try context.fetch(descriptor)
    }
    
    func get(id: Int) throws(LocalRepositoryError) -> DogBreed? {
        do {
            return try getBreed(by: id).map(\.dogBreed)
        } catch {
            throw LocalRepositoryError.invalidData
        }
    }
    
    private func getBreed(by id: Int) throws -> Breed? {
        let descriptor = FetchDescriptor<Breed>(
            predicate: #Predicate { breed in
                breed.id == id
            }
        )
        return try context.fetch(descriptor).first
    }
    
    func update(breed: DogBreed) async throws(LocalRepositoryError) {
        do {
            guard let existingBreed = try getBreed(by: breed.id) else {
                throw LocalRepositoryError.noData
            }
            existingBreed.name = breed.name
            existingBreed.size = breed.size
            existingBreed.lifeExpectancy = breed.lifeExpectancy
            existingBreed.temperament = breed.temperament
            existingBreed.origin = breed.origin
            existingBreed.activityLevel = breed.activityLevel
            try context.save()
        } catch {
            throw LocalRepositoryError.saveFailed
        }
    }
    
    func insert(breeds: [DogBreed]) async throws(LocalRepositoryError) {
        do {
            let storeBreeds = breeds.map(\.breed)
            storeBreeds.forEach { breed in
                context.insert(breed)
            }
            try context.save()
        } catch {
            throw LocalRepositoryError.saveFailed
        }
    }
    
    func deleteAll() async throws(LocalRepositoryError) {
        do {
            let breeds = try getBreeds()
            breeds.forEach { breed in
                context.delete(breed)
            }
            try context.save()
        } catch {
            throw LocalRepositoryError.saveFailed
        }
    }
    
    func upsert(breeds: [DogBreed]) async throws(LocalRepositoryError) {
        do {
                let existingBreeds = try getBreeds()

                let existingBreedsDict = Dictionary(uniqueKeysWithValues: existingBreeds.map { ($0.id, $0) })
                for breed in breeds {
                    if let existingBreed = existingBreedsDict[breed.id] {
                        existingBreed.name = breed.name
                        existingBreed.size = breed.size
                        if let lifeExpectancy = breed.lifeExpectancy {
                            existingBreed.lifeExpectancy = lifeExpectancy
                        }
                        if let temperament = breed.temperament {
                            existingBreed.temperament = temperament
                        }
                        if let origin = breed.origin {
                            existingBreed.origin = origin
                        }
                        if let activityLevel = breed.activityLevel {
                            existingBreed.activityLevel = activityLevel
                        }
                    } else {
                        let newBreed = breed.breed
                        context.insert(newBreed)
                    }
                }

                try context.save()
            } catch {
                throw LocalRepositoryError.saveFailed
            }
    }
}

extension Breed {
    var dogBreed: DogBreed {
        DogBreed(
            id: id,
            name: name,
            size: size,
            lifeExpectancy: lifeExpectancy,
            temperament: temperament,
            origin: origin,
            activityLevel: activityLevel
        )
    }
}

extension DogBreed {
    var breed: Breed {
        Breed(
            id: id,
            name: name,
            size: size,
            lifeExpectancy: lifeExpectancy,
            temperament: temperament,
            origin: origin,
            activityLevel: activityLevel
        )
    }
}

// To fix compiler warning that will be error in swift 6
extension ReferenceWritableKeyPath<Breed, Int>: @unchecked @retroactive Sendable {}
