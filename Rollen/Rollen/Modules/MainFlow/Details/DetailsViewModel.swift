//
//  DetailsViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.11.2024.
//


import Foundation

class DetailsViewModel {
    
    var selectedDish: Dish
    var addOns: [AddOn] = []
    var selectedAddOns: [AddOn] = []
    var ingredientImages: [String] = ["avocado.jpg", "friedSalmon.jpg", "ikra.jpg", "nori.jpg", "rice.jpg", "salmon.jpg"]
    
    init(dish: Dish) {
        self.selectedDish = dish
        loadAddOns()
    }
    
    private func loadAddOns() {
        // Добавьте загрузку доступных добавок (это примерные данные)
        addOns = [
            AddOn(name: "Сыр", price: 50),
            AddOn(name: "Соус", price: 30),
            AddOn(name: "Овощи", price: 40)
        ]
    }
    
    func addDishToOrder(quantity: Int) {
        var dishToAdd = OrderedDish(id: selectedDish.id, name: selectedDish.name, imagename: selectedDish.imagename, price: selectedDish.price, quantity: quantity)
        
        //TODO: addd addons
        selectedAddOns.forEach { addOn in
            dishToAdd.price += addOn.price
        }
        
        OrderStorage.shared.addDish(dishToAdd)
    }
    
    func selectAddOn(_ addOn: AddOn) {
        if !selectedAddOns.contains(where: { $0.name == addOn.name }) {
            selectedAddOns.append(addOn)
        }
    }
    
    func deselectAddOn(_ addOn: AddOn) {
        if let index = selectedAddOns.firstIndex(where: { $0.name == addOn.name }) {
            selectedAddOns.remove(at: index)
        }
    }
}
