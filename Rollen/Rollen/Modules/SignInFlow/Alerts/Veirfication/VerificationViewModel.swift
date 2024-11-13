//
//  VerificationViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 05.11.2024.
//

import Foundation

protocol VerificationFinishDelegate: AnyObject {
    func verificationFinish()
}

class VerificationViewModel: VerificationFinishDelegate {
    weak var coordinator: SignInCoordinator?
    private let userStorage = UserStorage.shared
    
    init(coordinator: SignInCoordinator? = nil) {
        self.coordinator = coordinator
    }

    func verificationFinish() {
        coordinator?.showNewPassword()
    }
}
