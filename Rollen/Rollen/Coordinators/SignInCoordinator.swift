//
//  SignInCoordinator.swift
//  Rollen
//
//  Created by Dmitry Belov on 31.10.2024.
//

import UIKit

class SignInCoordinator: Coordinator {
    
    override func start() {
        showSignIn()
    }
    
    override func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    private func showSignIn() {
        let signInViewController = ModuleFactory.makeSignIn(coordinator: self)
        navigationController?.pushViewController(signInViewController, animated: false)
    }
    
    func showForgotPassword() {
        print("showForgotPassword in SignInCoordinator")
        let forgotPasswordViewController = ModuleFactory.makeForgotPassword(coordinator: self)
        forgotPasswordViewController.modalPresentationStyle = .overFullScreen
        navigationController?.present(forgotPasswordViewController, animated: true)
    }
    
    func showVerificationPass() {
        print("showVerificationPass in SignInCoordinator")
        let verificationViewController = ModuleFactory.makeVerification(coordinator: self)
        verificationViewController.modalPresentationStyle = .overFullScreen
        navigationController?.visibleViewController?.present(verificationViewController, animated: true)
    }
    
    func showNewPassword() {
        let newPasswordViewController = ModuleFactory.makeNewPassword(coordinator: self)
        navigationController?.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(newPasswordViewController, animated: true)
    }
    
    func backToSignIn() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    func showSignUp() {
        let signUpViewController = ModuleFactory.makeSignUp(coordinator: self)
        if let sheet = signUpViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .none
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible = true
        }
        navigationController?.present(signUpViewController, animated: true, completion: nil)
    }
    
    func signUpFinish() {
        navigationController?.dismiss(animated: true, completion: nil)
        finish()
    }
}
