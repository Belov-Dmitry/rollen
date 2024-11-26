//
//  SignInViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.10.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    var viewModel: (SignInFinishDelegate)?
    
    // MARK: - UI Elements
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            AppColors.Blue.light.cgColor,
            AppColors.background.cgColor
        ]
        layer.locations = [0.0, 1.0]
        return layer
    }()
        private let logoImageView = LogoView()
        private let loginTextField = RegisterTextField(placeholder: ConstantsSignInVC.loginTF)
        private let passwordTextFiield = RegisterTextField(placeholder: ConstantsSignInVC.passwordTF)
    
        private let forgotPassLabel: UILabel = {
            let element = UILabel()
            element.text = ConstantsSignInVC.forgotPassLabel
            element.textColor = .systemGray2
            element.font = .boldSystemFont(ofSize: 12)
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
    private let goToMenuButton = RollButton(text: ConstantsSignInVC.rollButton, size: .large)
        
        private let imageView: UIView = {
            let element = UIView()
            element.backgroundColor = AppColors.Blue.light
            element.layer.cornerRadius = 25
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        private let chevron: UIImageView = {
            let element = UIImageView()
            element.image = UIImage(systemName: SystemImageName.chevronUp)
            element.tintColor = .white
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        private let signUpLabel: UILabel = {
            let element = UILabel()
            element.text = ConstantsSignInVC.signUpLabel
            element.textColor = .white
            element.font = .boldSystemFont(ofSize: 20)
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
    
    // MARK: - init
    init(viewModel: SignInFinishDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

}
//MARK: - Setting Views
private extension SignInViewController {
    func setupView() {
        addSubViews()
        addAction()
        setupLayout()
    }
}
//MARK: - Setting
private extension SignInViewController {
    func addSubViews() {
        view.layer.addSublayer(gradientLayer)
        view.addSubview(logoImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextFiield)
        
        view.addSubview(forgotPassLabel)
        view.addSubview(goToMenuButton)
        
        view.addSubview(imageView)
        view.addSubview(chevron)
        view.addSubview(signUpLabel)
    }
    
    func addAction () {
        let forgotPassLabelTap = UITapGestureRecognizer(target: self, action: #selector(forgotPassTap(_:)))
        self.forgotPassLabel.isUserInteractionEnabled = true
        self.forgotPassLabel.addGestureRecognizer(forgotPassLabelTap)
        
        goToMenuButton.addTarget(self, action: #selector(goToMenuButtonTapped), for: .touchUpInside)
        
        let signUpTap = UITapGestureRecognizer(target: self, action: #selector(signUpTap(_:)))
        self.signUpLabel.isUserInteractionEnabled = true
        self.signUpLabel.addGestureRecognizer(signUpTap)
    }
    
    @objc func forgotPassTap(_ sender: UITapGestureRecognizer) {
        viewModel?.showForgotPassword()
    }
    
    @objc private func goToMenuButtonTapped() {
        viewModel?.signInFinish()
    }
    
    @objc func signUpTap(_ sender: UITapGestureRecognizer) {
        viewModel?.showSignUp()
    }
}

//MARK: - Layout
private extension SignInViewController {
    func setupLayout() {
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50).isActive = true
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        passwordTextFiield.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 50).isActive = true
        passwordTextFiield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextFiield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        forgotPassLabel.topAnchor.constraint(equalTo: passwordTextFiield.bottomAnchor, constant: 50).isActive = true
        forgotPassLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        goToMenuButton.topAnchor.constraint(equalTo: forgotPassLabel.bottomAnchor, constant: 20).isActive = true
        goToMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        goToMenuButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        chevron.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        chevron.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true

        signUpLabel.centerXAnchor.constraint(equalTo: chevron.centerXAnchor).isActive = true
        signUpLabel.topAnchor.constraint(equalTo: chevron.bottomAnchor, constant: 0).isActive = true
    }
}
