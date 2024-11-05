//
//  SignInCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class SignInCoordinator: Coordinator {
    
    override func start() {
        showSignIn()
    }
    override func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

private extension SignInCoordinator {
    func showSignIn() {
        let signInViewController = ModuleFactory.makeSignIn(coordinator: self)
        navigationController?.pushViewController(signInViewController, animated: true)
    }
}
