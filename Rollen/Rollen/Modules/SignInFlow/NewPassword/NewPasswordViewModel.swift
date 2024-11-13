//
//  NewPasswordViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 05.11.2024.
//

import Foundation

protocol NewPasswordFinishDelegate: AnyObject {
    func newPasswordFinish()
}

class NewPasswordViewModel: NewPasswordFinishDelegate {
    weak var coordinator: SignInCoordinator?
    private let userStorage = UserStorage.shared
    
    init(coordinator: SignInCoordinator? = nil) {
        self.coordinator = coordinator
    }

    func newPasswordFinish() {
        coordinator?.finish()
    }
}
