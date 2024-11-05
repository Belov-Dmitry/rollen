//
//  UserStorage.swift
//  Rollen
//
//  Created by Dmitry Belov on 03.11.2024.
//

import Foundation

class UserStorage {
    
    static let shared = UserStorage()
    
    var isOnboardingComplete: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKey.isOnboardingComplete) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.isOnboardingComplete) }
    }
}
