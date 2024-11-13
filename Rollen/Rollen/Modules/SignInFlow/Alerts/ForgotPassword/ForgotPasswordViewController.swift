//
//  ForgotPasswordViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 09.11.2024.
//


import UIKit
//MARK: - ForgotPassAlertVC
final class ForgotPasswordViewController: UIViewController {
    
    var viewModel: (ForgotPasswordFinishDelegate)?
    
    //MARK: - Private Property
   
    private let alertView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = AppColors.Blue.light
        element.layer.cornerRadius = 10
        return element
    }()
    private let cancelButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.setTitle("✖", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        element.layer.cornerRadius = 10
        return element
    }()
    private let titleAlertLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = ConstantsAlert.titleAlertLabel
        element.textColor = AppColors.background
        element.font = UIFont.boldSystemFont(ofSize: 20)
        return element
    }()

    let emailTextField = RegisterTextField(placeholder: ConstantsAlert.emailTextField)
    let resetButton = RollButton(text: ConstantsAlert.resetButton, size: .large)
    
    // MARK: - init
    init(viewModel: ForgotPasswordFinishDelegate? = nil) {
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
private extension ForgotPasswordViewController {
    func setupView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        addSubViews()
        addAction()
        setupLayout()
    }
}
//MARK: - Setting
private extension ForgotPasswordViewController {
    func addSubViews() {
        view.addSubview(alertView)
        alertView.addSubview(cancelButton)
        alertView.addSubview(titleAlertLabel)
        alertView.addSubview(emailTextField)
        alertView.addSubview(resetButton)
    }
    
    func addAction () {
        cancelButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
    }
    
    @objc func resetPassword() {
        viewModel?.showVerificationPass()
    }
    
    @objc func dismissAlert() {
        print("dismissAlert in ForgotPasswordViewController")
        viewModel?.backToSignIn()
    }
}
//MARK: - Layout
private extension ForgotPasswordViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            alertView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            cancelButton.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            cancelButton.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalToConstant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            
            titleAlertLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 20),
            titleAlertLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: titleAlertLabel.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.8),
            
            resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            resetButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            resetButton.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.6),
        ])
    }
}
