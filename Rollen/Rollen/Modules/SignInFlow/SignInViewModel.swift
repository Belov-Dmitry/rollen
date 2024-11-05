//
//  SignInViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 05.11.2024.
//

import Foundation

protocol SignInFinishDelegate: AnyObject {
    func signInFinish()
}

class SignInViewModel: SignInFinishDelegate {
    weak var coordinator: SignInCoordinator?
    private let userStorage = UserStorage.shared
    
    init(coordinator: SignInCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    
    
    
    func signInFinish() {
        //userStorage.isOnboardingComplete = true
        print("signIn Coordinator Finish")
        coordinator?.finish()
    }
    
    
}
