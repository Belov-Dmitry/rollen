//
//  OrderStorage.swift
//  Rollen
//
//  Created by Dmitry Belov on 26.11.2024.
//


class OrderStorage {
    static let shared = OrderStorage()
    private(set) var orderedDishes: [OrderedDish] = []
    
    private init() {}
    
    func addDish(_ dish: Dish) {
        if let index = orderedDishes.firstIndex(where: { $0.id == dish.id }) {
            orderedDishes[index].quantity += 1
        } else {
            let orderedDish = OrderedDish(id: dish.id, name: dish.name, price: dish.price, quantity: 1)
            orderedDishes.append(orderedDish)
        }
    }
    
    func removeDish(_ dish: Dish) {
        if let index = orderedDishes.firstIndex(where: { $0.id == dish.id }) {
            orderedDishes[index].quantity -= 1
            if orderedDishes[index].quantity == 0 {
                orderedDishes.remove(at: index)
            }
        }
    }
    
    func clearOrder() {
        orderedDishes.removeAll()
    }
}
