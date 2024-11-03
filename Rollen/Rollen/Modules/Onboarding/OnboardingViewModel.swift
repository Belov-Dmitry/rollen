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
    
    init(coordinator: OnboardingCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    
    
    
    func onboardingFinish() {
        coordinator?.finish()
    }
    
    
}
