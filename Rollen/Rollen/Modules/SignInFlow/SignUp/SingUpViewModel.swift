//
//  SignUpViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 05.11.2024.
//

import Foundation

protocol SignUpFinishDelegate: AnyObject {
    func signUpFinish()
}

class SignUpViewModel: SignUpFinishDelegate {
    weak var coordinator: SignInCoordinator?
    private let userStorage = UserStorage.shared
    
    init(coordinator: SignInCoordinator? = nil) {
        self.coordinator = coordinator
    }
 
    func signUpFinish() {
        //userStorage.isOnboardingComplete = true
        print("SignUpFinish")
        coordinator?.signUpFinish()
    }
    
    
}
