//
//  SignInCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class SignInCoordinator: Coordinator {
    
    override func start() {
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
