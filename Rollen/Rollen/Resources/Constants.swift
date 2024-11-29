//
//  Constants.swift
//  Rollen
//
//  Created by Dmitry Belov on 05.11.2024.
//

enum UserDefaultsKey {
    static let isOnboardingComplete = "isOnboardingComplete"
}
enum ImageName {
    static let logo = "LogoCircle"
    static let sideMenuButtonImage = "sideMenuButtonImage"
    static let basketButtonImage = "basketButtonImage"
    static let backButtonImage = "backButtonImage"
    static let close = "close"
    
    static let menuProfile = "profile"
    static let menuWishlist = "wishlist"
    static let menuLoyaltyPoints = "loyaltyPoints"
    static let menuPaymentMethods = "paymentMethods"

}
enum SystemImageName {
    static let arrowRight = "arrow.right"
    static let chevronUp = "chevron.up"
}
enum ConstantsOnboarding {
    static let welcomeLabelText = "Добро пожаловать!"
    static let topLabelText = "Роллы, которые доставляют удовоствие!"
    static let startButtonText = "Хочу есть!"
}
enum ConstantsSignInVC {
    static let loginTF = "Email"
    static let passwordTF = "Password"
    static let forgotPassLabel = "Forgot Password?"
    static let rollButton = "Eat Away!"
    static let signUpLabel = "Sign Up"
}
enum ConstantsSignUpVC {
    static let nameTF = "Name"
    static let loginTF = "Email"
    static let passwordTF = "Password"
    static let conformPasswordTF = "Conform Password"
    static let rollButton = "Never Hungry Again!"
}
enum ConstantsNewPass {
    static let topLabel = "Your password must be at-least 8 characters long."
    static let newPassTF = "Enter new password"
    static let passwordTF = "Reconfirm new password"
    static let rollButton = "Eat Away!"
}
enum ConstantsAlert {
    static let titleAlertLabel = "Forgot Password"
    static let titleLabel = "Verification Code"
    static let smallTitleLabel = "A verification code has been sent to your mail"
    static let emailTextField = "Enter your account email"
    static let resetButton = "Reset Password"
    static let changeButton = "Change Email"
}
