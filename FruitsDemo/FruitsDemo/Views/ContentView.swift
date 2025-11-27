
import SwiftUI

struct ContentView: View {
    @StateObject private var fruitStore = FruitStore()
    @State private var showingAddFruit = false
    @State private var newFruit = FruitStore.defaultFruit
    @State private var showingError = false
    @State private var errorMessage = ""
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        newFruit = FruitStore.defaultFruit
                        showingAddFruit = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddFruit) {
                NavigationView {
                    AddFruitView(newFruit: $newFruit)
                        .navigationTitle("Add Fruit")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    showingAddFruit = false
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Save") {
                                    if fruitStore.addFruit(newFruit) {
                                        showingAddFruit = false
                                    } else {
                                        if newFruit.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                            errorMessage = "El nombre de la fruta no puede estar vacío"
                                        } else {
                                            errorMessage = "Ya existe una fruta con ese nombre"
                                        }
                                        showingError = true
                                    }
                                }
                            }
                        }
                }
            }
            .alert(isPresented: $showingError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
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
