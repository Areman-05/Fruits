import Foundation
class FruitStore:ObservableObject{
    
    @Published var fruits = loadFruits()
    
    static func loadFruits()->[Fruit]{
        return FruitStore.defaultFruits
    }
    
    static let defaultFruits = [
        Fruit(name: "Apple", emoji: .apple, description: "Apples help your body develop resistance against infections"),
        Fruit(name: "Pineapple", emoji: .pineapple, description: "Pineapples help fight arthritis"),
        Fruit(name: "Watermelon", emoji: .watermelon, description: "Watermelon helps control your heart rate"),
    ]
    
    static let defaultFruit =  Fruit(name: "Watermelon", emoji: .watermelon, description: "Watermelon helps control your heart rate")
    
    func addFruit(_ fruit: Fruit) -> Bool {
        // Validar que el nombre no esté vacío
        guard !fruit.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        
        // Validar que no exista una fruta con el mismo nombre
        guard !fruits.contains(where: { $0.name.lowercased() == fruit.name.lowercased() }) else {
            return false
        }
        
        fruits.append(fruit)
        return true
    }
    
}
