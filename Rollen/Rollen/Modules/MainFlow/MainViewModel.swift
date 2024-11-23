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
    
    init(coordinator: MainCoordinator? = nil) {
        self.coordinator = coordinator
        makeDishTypeArray()
    }
    
    func mainFinish() {
        coordinator?.finish()
    }
    
    func makeDishTypeArray() {
        print(#function)
            dishTypeArray = [
                DishType(dishTypeName: "Холодные роллы", dishTypeImage: UIImage(named: "060")!),
                DishType(dishTypeName: "Запечённые роллы", dishTypeImage: UIImage(named: "056")!),
                DishType(dishTypeName: "Темпура роллы", dishTypeImage: UIImage(named: "031")!),
                DishType(dishTypeName: "Сеты", dishTypeImage: UIImage(named: "081")!),
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
