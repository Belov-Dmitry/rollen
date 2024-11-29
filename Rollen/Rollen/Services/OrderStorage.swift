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
    
    func addDish(_ dish: OrderedDish) {
        if let index = orderedDishes.firstIndex(where: { $0.id == dish.id }) {
            orderedDishes[index].quantity += dish.quantity
            //orderedDishes[index].price += dish.price
        } else {
            orderedDishes.append(dish)
        }
    }
    
    func removeDish(_ dish: OrderedDish) {
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

