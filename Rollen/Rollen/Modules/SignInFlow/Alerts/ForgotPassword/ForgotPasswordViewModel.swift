//
//  ForgotPasswordViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 05.11.2024.
//

import Foundation

protocol ForgotPasswordFinishDelegate: AnyObject {
    func forgotPasswordFinish()
    func showVerificationPass()
    func backToSignIn()
}

class ForgotPasswordViewModel: ForgotPasswordFinishDelegate {
    weak var coordinator: SignInCoordinator?
    private let userStorage = UserStorage.shared
    
    init(coordinator: SignInCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func showVerificationPass() {
        coordinator?.showVerificationPass()
        }
    
    func forgotPasswordFinish() {
        //userStorage.isOnboardingComplete = true
        print("ForgotPasswordFinish in ForgotPasswordViewModel")
        //coordinator?.finish()
    }
    
    func backToSignIn() {
        coordinator?.backToSignIn()
    }
    
}
