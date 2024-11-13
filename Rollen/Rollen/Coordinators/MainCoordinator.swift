//
//  MainCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    
    override func start() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
