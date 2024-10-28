//
//  SceneDelegate.swift
//  Rollen
//
//  Created by Dmitry Belov on 25.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

          guard let windowScene = (scene as? UIWindowScene) else { return }
          window = UIWindow(windowScene: windowScene)
          //let viewController = ViewController()
          let viewController = OnboardingViewController()
          let navigationVC = UINavigationController(rootViewController: viewController)
          window?.rootViewController = navigationVC
          window?.makeKeyAndVisible()
      }

}

