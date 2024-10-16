import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel
    var breed: DogBreed? {
        viewModel.breed
    }
    
    var body: some View {
        Group {
            if let breed {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(breed.name)
                            .font(.largeTitle)
                            .bold()
                            .padding(.bottom, 10)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            DetailRow(title: "Size", value: breed.size)
                            
                            if let lifeExpectancy = breed.lifeExpectancy {
                                DetailRow(title: "Life Expectancy", value: lifeExpectancy)
                            }
                            
                            if let temperament = breed.temperament {
                                DetailRow(title: "Temperament", value: temperament)
                            }
                            
                            if let origin = breed.origin {
                                DetailRow(title: "Origin", value: origin)
                            }
                            
                            if let activityLevel = breed.activityLevel {
                                DetailRow(title: "Activity Level", value: activityLevel)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor.secondarySystemBackground))
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                        
                        Spacer()
                    }
                    .padding()
                }
            } else {
                VStack {
                    ProgressView()
                    Text("Loading breed details...")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("Breed Details")
        .task { [viewModel] in
            await viewModel.getBreedDetails()
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(title):")
                .fontWeight(.semibold)
            Text(value)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}
