//
//  OnboardingCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    override func start() {
        showOnboarding()
    }
    override func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

private extension OnboardingCoordinator {
    func showOnboarding() {
        let onboardingViewController = ModuleFactory.makeOnboarding(coordinator: self)
        navigationController?.pushViewController(onboardingViewController, animated: true)
    }
}
