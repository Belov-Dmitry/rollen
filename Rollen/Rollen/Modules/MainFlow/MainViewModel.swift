//
//  MainViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 23.11.2024.
//

import Foundation
import UIKit

protocol MainFinishDelegate: AnyObject {
    
    var dishTypeArray: [DishType] { get set }
    
    func mainFinish()
    func makeDishTypeArray()
}

class MainViewModel: MainFinishDelegate {
    
    weak var coordinator: MainCoordinator?
    
    var dishTypeArray: [DishType] = []
    var dishes: [Dish] = []
    var filteredDishes: [Dish] = []
    
    init(coordinator: MainCoordinator? = nil) {
        self.coordinator = coordinator
        makeDishTypeArray()
        loadDishes()
    }
    
    func mainFinish() {
        coordinator?.finish()
    }
    
    private func loadDishes() {
        guard let url = Bundle.main.url(forResource: "dishes", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            dishes = try JSONDecoder().decode([Dish].self, from: data) } catch { print("Error loading dishes: \(error)")
            }
    }
    
    func filterDishes(by type: String) {
        filteredDishes = dishes.filter { $0.type == type }
        print("filterDishes by type: \(type)")
        print("filteredDishes count: \(filteredDishes.count)")
    }
    
    func makeDishTypeArray() {
            dishTypeArray = [
                DishType(dishTypeName: "Холодные роллы", dishTypeImage: UIImage(named: "060")!),
                DishType(dishTypeName: "Запеченные роллы", dishTypeImage: UIImage(named: "056")!),
                DishType(dishTypeName: "Темпура роллы", dishTypeImage: UIImage(named: "031")!),
                DishType(dishTypeName: "Сеты", dishTypeImage: UIImage(named: "083")!),
                DishType(dishTypeName: "Суши", dishTypeImage: UIImage(named: "023")!),
                DishType(dishTypeName: "Закуски", dishTypeImage: UIImage(named: "012")!),
                DishType(dishTypeName: "Wok", dishTypeImage: UIImage(named: "009")!),
                DishType(dishTypeName: "Паста", dishTypeImage: UIImage(named: "005")!),
                DishType(dishTypeName: "Супы", dishTypeImage: UIImage(named: "003")!),
                DishType(dishTypeName: "Десерты", dishTypeImage: UIImage(named: "002")!),
                DishType(dishTypeName: "Напитки", dishTypeImage: UIImage(named: "001")!)
            ]
        }
}
