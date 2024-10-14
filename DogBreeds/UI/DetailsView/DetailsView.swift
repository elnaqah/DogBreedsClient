import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel
    var breed: DogBreed? {
        viewModel.breed
    }
    
    var body: some View {
        if let breed {
            VStack(alignment: .leading, spacing: 20) {
                Text(breed.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("Size: \(breed.size)")
                    .font(.title2)
                
                if let lifeExpectancy = breed.lifeExpectancy {
                    Text("Life Expectancy: \(lifeExpectancy)")
                }
                
                if let temperament = breed.temperament {
                    Text("Temperament: \(temperament)")
                }
                
                if let origin = breed.origin {
                    Text("Origin: \(origin)")
                }
                
                if let activityLevel = breed.activityLevel {
                    Text("Activity Level: \(activityLevel)")
                }
                
                Spacer()
            }
            .padding()
        } else {
            ProgressView()
        }
    }
}
