import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading breeds...")
                } else if viewModel.breeds.isEmpty {
                    Text("No breeds available")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.breeds, id: \.id) { breed in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(breed.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Size: \(breed.size)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .contentShape(Rectangle()) // For better tap detection
                        .onTapGesture {
                            viewModel.openDetails(for: breed)
                        }
                    }
                }
            }
            .navigationTitle("Dog Breeds")
            .task {
                await viewModel.fetchBreeds()
            }
        }
    }
}
