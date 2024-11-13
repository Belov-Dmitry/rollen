//
//  NewPasswordViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 09.11.2024.
//


import UIKit

//MARK: - NewPasswordViewController
final class NewPasswordViewController: UIViewController {
    
    var viewModel: (NewPasswordFinishDelegate)?
    
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
    
    private let topLabel: UILabel = {
        let element = UILabel()
        element.text = ConstantsNewPass.topLabel
        element.textAlignment = .center
        element.numberOfLines = 0
        element.textColor = .white
        element.font = .boldSystemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let newPassTF = RegisterTextField(placeholder: ConstantsNewPass.newPassTF)
    private let passwordTF = RegisterTextField(placeholder: ConstantsNewPass.passwordTF)
    private let myButton = RollButton(text: ConstantsNewPass.rollButton, size: .large)
    
    
    // MARK: - init
    init(viewModel: NewPasswordFinishDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
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
private extension NewPasswordViewController {
    func setupView() {
        view.backgroundColor = AppColors.Blue.light
        addSubViews()
        addAction()
        setupLayout()
    }
}

//MARK: - Setting Views
private extension NewPasswordViewController {
    func addSubViews() {
        view.layer.addSublayer(gradientLayer)
        view.addSubview(logoImageView)
        view.addSubview(topLabel)
        view.addSubview(newPassTF)
        view.addSubview(passwordTF)
        view.addSubview(myButton)
    }
    
    func addAction () {
        myButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    @objc private func selectButtonTapped() {
        viewModel?.newPasswordFinish()
    }
}

//MARK: - setupLayout
private extension NewPasswordViewController {
    func setupLayout() {
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        topLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        newPassTF.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 50).isActive = true
        newPassTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newPassTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        passwordTF.topAnchor.constraint(equalTo: newPassTF.bottomAnchor, constant: 50).isActive = true
        passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        myButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 50).isActive = true
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
    }
}
