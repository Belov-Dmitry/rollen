//
//  Coordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import Foundation
import UIKit

enum CoordinatorType {
    case app, onboarding, signIn, profile, main, cart, tabbar
}

protocol CoordinatorProtocol: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }

    func start()
    func finish()
}

extension CoordinatorProtocol {
    func addChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    func removeChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter{ $0 !== childCoordinator }
    }
   
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

protocol TabBarCoordinator: AnyObject, CoordinatorProtocol {
    var tabBarController: UITabBarController? { get set }
}

class Coordinator: CoordinatorProtocol {
    var finishDelegate: (any CoordinatorFinishDelegate)?
    var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorProtocol]()
    var type: CoordinatorType
    
    init(finishDelegate: (any CoordinatorFinishDelegate)? = nil,
         navigationController: UINavigationController,
         childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](),
         type: CoordinatorType) {
        self.finishDelegate = finishDelegate
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
        self.type = type
    }
    
    deinit {
        print("Coordinator \(type) deinited")
        childCoordinators.forEach{ $0.finishDelegate = nil }
        childCoordinators.removeAll()
    }
    
    func start() {
        print("Coordinator start")
    }
    func finish() {
        print("Coordinator finish")
//        childCoordinators.removeAll()
//        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
}
