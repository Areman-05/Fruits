
import SwiftUI

struct ContentView: View {
    @StateObject private var fruitStore = FruitStore()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fruitStore.fruits) { fruit in
                    NavigationLink(destination: DetailFruitView(fruit: fruit)) {
                        FruitRowView(fruit: fruit)
                    }
                }
                .onDelete(perform: deleteFruits)
            }
            .navigationTitle("Fruits")
        }
    }
    
    private func deleteFruits(offsets: IndexSet) {
        fruitStore.fruits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
