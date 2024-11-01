//
//  CartCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class CartCoordinator: Coordinator {
    
    override func start() {
        let vc = CartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
