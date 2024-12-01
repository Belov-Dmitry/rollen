//
//  CartViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 29.11.2024.
//


import Foundation

class CartViewModel {
    private(set) var orderedDishes: [OrderedDish] = []
    var deliveryCost: Int = 500 // Стоимость доставки фиксирована. нужно добавить расчёт сколько осталось до бесплатной доставки
    
    init() {
        fetchOrderedDishes()
    }
    
    var totalOrderCost: Int {
        return orderedDishes.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
    
    var totalCost: Int {
        return totalOrderCost + deliveryCost
    }
    
    func fetchOrderedDishes() {
        print("fetchOrderedDishes1 \(orderedDishes)")
        orderedDishes = OrderStorage.shared.orderedDishes
        print("fetchOrderedDishes2 \(orderedDishes)")
    }
    
    func addDish(_ dish: OrderedDish) {
        if let index = orderedDishes.firstIndex(where: { $0.id == dish.id }) {
            orderedDishes[index].quantity += dish.quantity
            orderedDishes[index].price += dish.price
        } else {
            orderedDishes.append(dish)
        }
    }
    
    func removeDish(_ dish: OrderedDish) {
        if let index = orderedDishes.firstIndex(where: { $0.id == dish.id }) {
            orderedDishes.remove(at: index)
        }
    }
    
    func clearOrder() {
        orderedDishes.removeAll()
    }
}
