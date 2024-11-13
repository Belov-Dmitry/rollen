//
//  OnboardingViewModel.swift
//  Rollen
//
//  Created by Dmitry Belov on 03.11.2024.
//

import Foundation

protocol OnboardingFinishDelegate: AnyObject {
    func onboardingFinish()
}

class OnboardingViewModel: OnboardingFinishDelegate {
    
    weak var coordinator: OnboardingCoordinator?
    
    private let userStorage = UserStorage.shared
    
    init(coordinator: OnboardingCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func onboardingFinish() {
        userStorage.isOnboardingComplete = true
        coordinator?.finish()
    }
}
