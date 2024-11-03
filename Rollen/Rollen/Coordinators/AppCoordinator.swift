//
//  AppCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let userStorage = UserStorage.shared
    
    override func start() {
        if userStorage.isOnboardingPassed {
            ShowMainFlow()
        } else {
            showOnboardingFlow()
        }
    }
    
}
//MARK: - Navigation methods
private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = OnboardingCoordinator(finishDelegate: self, navigationController: navigationController, type: .onboarding)
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
        
    }
    func ShowSignInFlow() {
        guard let navigationController = navigationController else { return }
        let signInNavigationController = UINavigationController()
        let signInCoordinator = SignInCoordinator(navigationController: signInNavigationController, type: .signIn)
        signInCoordinator.finishDelegate = self
        signInCoordinator.start()
    }
    func ShowMainFlow() {
        guard let navigationController = navigationController else { return }
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, type: .profile)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), tag: 1)
        let mainCoordinator = MainCoordinator(navigationController: mainNavigationController, type: .main)
        mainCoordinator.finishDelegate = self
        mainCoordinator.start()
        
        let cartNavigationController = UINavigationController()
        cartNavigationController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "basket"), tag: 2)
        let cartCoordinator = CartCoordinator(navigationController: cartNavigationController, type: .cart)
        cartCoordinator.finishDelegate = self
        cartCoordinator.start()
        
        addChildCoordinator(profileCoordinator)
        addChildCoordinator(mainCoordinator)
        addChildCoordinator(cartCoordinator)
        
        let tabBarControllers = [profileNavigationController, mainNavigationController, cartNavigationController]
        let tabBarViewController = TabBarController(tabBarControllers: tabBarControllers)
        navigationController.pushViewController(tabBarViewController, animated: true)
    }
}
extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .onboarding:
            navigationController?.viewControllers.removeAll()
            ShowMainFlow()
        case .app:
            return
        default:
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
