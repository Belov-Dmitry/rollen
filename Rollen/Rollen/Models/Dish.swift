//
//  Dish.swift
//  Rollen
//
//  Created by Dmitry Belov on 18.11.2024.
//

import UIKit

struct DishType {
    let dishTypeName: String
    let dishTypeImage: UIImage
}

struct Dish: Decodable {
    let id: Int
    let type: String
    let name: String
    let imagename: String
    let ingredients: String
    let weight: Int
    let price: Int
    //let isAvailable: Bool
}

struct OrderedDish {
    let id: Int
    let name: String
    let price: Int
    var quantity: Int
}
