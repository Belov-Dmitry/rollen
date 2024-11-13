//
//  VerificationViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 09.11.2024.
//


import UIKit

final class VerificationViewController: UIViewController {
    
    var viewModel: (VerificationFinishDelegate)?
    
    //MARK: - Private Property
    private let alertView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = AppColors.Blue.light
        element.layer.cornerRadius = 10
        return element
    }()
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = ConstantsAlert.titleLabel
        element.textColor = AppColors.background
        element.font = UIFont.boldSystemFont(ofSize: 20)
        return element
    }()
    
    private let smallTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = ConstantsAlert.smallTitleLabel
        element.textColor = .white
        element.font = UIFont.boldSystemFont(ofSize: 12)
        return element
    }()
    
    private let emailTextField = RegisterTextField(placeholder: ConstantsAlert.titleLabel)
    
    private let resetPasswordButton = RollButton(text: ConstantsAlert.resetButton, size: .large)
    
    private let changeEMailButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle(ConstantsAlert.changeButton, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        return element
    }()
    
    // MARK: - init
    init(viewModel: VerificationFinishDelegate? = nil) {
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
private extension VerificationViewController {
    func setupView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        addSubViews()
        addAction()
        setupLayout()
    }
}
    //MARK: - Setting Views
private extension VerificationViewController {
    func addSubViews() {
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(smallTitleLabel)
        alertView.addSubview(emailTextField)
        alertView.addSubview(resetPasswordButton)
        alertView.addSubview(changeEMailButton)
    }
    func addAction () {
        resetPasswordButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        changeEMailButton.addTarget(self, action: #selector(backToForgotPassToChangeEMail), for: .touchUpInside)
    }
    @objc func resetPassword() {
        print("VerificationFinish in VerificationViewController")
        viewModel?.verificationFinish()
    }
    @objc func backToForgotPassToChangeEMail() {
        print("dismissAlert in backToForgotPassToChangeEMail")
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: - Layout
private extension VerificationViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            alertView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            
            smallTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            smallTitleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: smallTitleLabel.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.8),
            
            resetPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            resetPasswordButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            resetPasswordButton.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.6),
            
            changeEMailButton.topAnchor.constraint(equalTo: resetPasswordButton.bottomAnchor, constant: 20),
            changeEMailButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
        ])
    }
}
