import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.breeds, id: \.id) { breed in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(breed.name)
                                .font(.headline)
                            Text("Size: \(breed.size)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                    .onTapGesture {
                        viewModel.openDetails(for: breed)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchBreeds()
        }
    }
}
