//
//  AppCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let userStorage = UserStorage.shared
    private let factory = ModuleFactory.self
    
    override func start() {
        ShowMainFlow()
        //showOnboardingFlow()
        //ShowSignInFlow()
//        if userStorage.isOnboardingComplete {
//            ShowMainFlow()
//        } else {
//            showOnboardingFlow()
//        }
    }
    
}
//MARK: - Navigation methods
private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        factory.makeOnboardingFlow(coordinator: self, finishDelegate: self, navigationController: navigationController)
        
    }
    func ShowSignInFlow() {
        guard let navigationController = navigationController else { return }
        factory.makeSignInFlow(coordinator: self, finishDelegate: self, navigationController: navigationController)
    }
    func ShowMainFlow() {
        guard let navigationController = navigationController else { return }
        let tabBarViewController = factory.makeMainFlow(coordinator: self, finishDelegate: self)
        navigationController.pushViewController(tabBarViewController, animated: false)
    }
}
extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .onboarding:
            navigationController?.viewControllers.removeAll()
            ShowSignInFlow()
        case .signIn:
            navigationController?.viewControllers.removeAll()
            ShowMainFlow()
        case .app:
            return
        default:
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
