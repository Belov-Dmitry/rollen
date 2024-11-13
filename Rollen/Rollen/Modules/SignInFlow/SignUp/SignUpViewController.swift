//
//  SignUpViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 09.11.2024.
//


import UIKit

//MARK: - SingUpViewController
final class SignUpViewController: UIViewController {
    
    var viewModel: SignUpFinishDelegate?
    
    //MARK: - Private Property
    private let signUpLabel: UILabel = {
        let element = UILabel()
        element.text = ConstantsSignInVC.signUpLabel
        element.textColor = .white
        element.textAlignment = .center
        element.font = UIFont.systemFont(ofSize: 20)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let nameTF = RegisterTextField(placeholder: ConstantsSignUpVC.nameTF)
    private let loginTF = RegisterTextField(placeholder: ConstantsSignUpVC.loginTF)
    private let passwordTF = RegisterTextField(placeholder: ConstantsSignUpVC.passwordTF)
    private let conformPasswordTF = RegisterTextField(placeholder: ConstantsSignUpVC.conformPasswordTF)
    
    private let goToMenuButton = RollButton(text: ConstantsSignUpVC.rollButton, size: .large)
    
    // MARK: - init
    init(viewModel: SignUpFinishDelegate? = nil) {
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
}

//MARK: - Setting Views
private extension SignUpViewController {
    func setupView() {
        view.backgroundColor = AppColors.Blue.light
        addSubViews()
        addAction()
        setupLayout()
    }
}
//MARK: - Setting Views
private extension SignUpViewController {
    func addSubViews() {
        view.addSubview(signUpLabel)
        view.addSubview(nameTF)
        view.addSubview(loginTF)
        view.addSubview(passwordTF)
        view.addSubview(conformPasswordTF)
        view.addSubview(goToMenuButton)
    }
    
    func addAction () {
        goToMenuButton.addTarget(self, action: #selector(goToMenuButtonTapped), for: .touchUpInside)
    }
    
    @objc private func goToMenuButtonTapped() {
        viewModel?.signUpFinish()
    }
}
//MARK: - Layout
private extension SignUpViewController {
    func setupLayout() {
        signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameTF.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 40).isActive = true
        nameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        loginTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 40).isActive = true
        loginTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 40).isActive = true
        passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        conformPasswordTF.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 40).isActive = true
        conformPasswordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        conformPasswordTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        goToMenuButton.topAnchor.constraint(equalTo: conformPasswordTF.bottomAnchor, constant: 80).isActive = true
        goToMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goToMenuButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
    }
}
