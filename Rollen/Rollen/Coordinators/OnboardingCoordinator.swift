//
//  OnboardingCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    override func start() {
        let vc = OnboardingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

