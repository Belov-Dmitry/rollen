//
//  Dish.swift
//  Rollen
//
//  Created by Dmitry Belov on 18.11.2024.
//

import UIKit

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
