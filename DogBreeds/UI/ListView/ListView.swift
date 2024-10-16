import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    
    var body: some View {
        NavigationView {
            List {
                if let errorMessage = viewModel.errorMessage {
                    BannerView(message: errorMessage)
                }
                if viewModel.isLoading {
                    ProgressView("Loading breeds...")
                } else if viewModel.breeds.isEmpty {
                    Text("No breeds available")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.breeds, id: \.id) { breed in
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
            .refreshable {
                await viewModel.fetchBreeds()
            }
        }
    }
}
