import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    let dogBreeds: [DogBreed] = [
        DogBreed(id: 1, name: "Golden Retriever", size: "Large", lifeExpectancy: "10-12 years", temperament: "Friendly", origin: "Scotland", activityLevel: "High"),
        DogBreed(id: 2, name: "Beagle", size: "Medium", lifeExpectancy: "12-15 years", temperament: "Curious", origin: "England", activityLevel: "Medium"),
        DogBreed(id: 3, name: "Chihuahua", size: "Small", lifeExpectancy: "12-20 years", temperament: "Loyal", origin: "Mexico", activityLevel: "Low"),
        DogBreed(id: 4, name: "Great Dane", size: "Extra Large", lifeExpectancy: "7-10 years", temperament: "Gentle", origin: "Germany", activityLevel: "Moderate"),
        DogBreed(id: 5, name: "Bulldog", size: "Medium", lifeExpectancy: "8-12 years", temperament: "Docile", origin: "England", activityLevel: "Low")
    ]
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
