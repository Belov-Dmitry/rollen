//
//  OrderReviewViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 01.12.2024.
//

import Foundation

class OrderReviewViewModel {
    private let deliveryCost: Int = 500
    
    var orderedDishes: [OrderedDish] {
        return OrderStorage.shared.orderedDishes
    }
    
    var totalOrderCost: Int {
        return orderedDishes.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
    
    var totalCost: Int {
        return totalOrderCost + deliveryCost
    }
    
    func getOrderDetails(deliveryMethod: Int, deliveryAddress: String?) -> String {
        var orderDetails = ""
        
        for dish in orderedDishes {
            orderDetails += "\(dish.name) x\(dish.quantity)\n"
        }
        
        orderDetails += "\n"
        
        if deliveryMethod == 0 {
            orderDetails += "Самовывоз: Ленина 125, Ростов-на-Дону"
        } else if deliveryMethod == 1, let address = deliveryAddress {
            orderDetails += "Доставка: \(address)"
        }
        return orderDetails
    }
}

