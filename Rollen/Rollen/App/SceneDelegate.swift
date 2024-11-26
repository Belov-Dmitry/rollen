//
//  SceneDelegate.swift
//  Rollen
//
//  Created by Dmitry Belov on 25.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

          guard let windowScene = (scene as? UIWindowScene) else { return }
          window = UIWindow(windowScene: windowScene)
          let navigationVC = UINavigationController()
        navigationVC.navigationBar.isHidden = true //скрытие первого NavigationController в NavigationController
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.tabbarBackground
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        
        
          window?.rootViewController = navigationVC
          window?.makeKeyAndVisible()
        let appCoordinator = AppCoordinator(navigationController: navigationVC, type: .app)
        appCoordinator.start()
      }
}

