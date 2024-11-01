//
//  TabBarController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.10.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        for tab in tabBarControllers {
            self.addChild(tab)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .accentDarkBlue
        tabBar.tintColor = .accentLightRed
        tabBar.unselectedItemTintColor = .accentDarkYellow
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = 38
        tabBar.itemSpacing = 36
        
    }
    

}
