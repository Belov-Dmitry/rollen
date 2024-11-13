//
//  OnboardingViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.10.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var viewModel: (OnboardingFinishDelegate)?
    
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
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantsOnboarding.welcomeLabelText
        label.textAlignment = .center
        label.font = .Sen.medium.size(of: 30)
        label.textColor = AppColors.tabbarInactiveButton
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantsOnboarding.topLabelText
        label.textAlignment = .center
        label.font = .Sen.regular.size(of: 20)
        label.textColor = AppColors.tabbarInactiveButton
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(ConstantsOnboarding.startButtonText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .semibold)
        button.backgroundColor = AppColors.tabbarActiveButton
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 23
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - init
    init(viewModel: OnboardingFinishDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.layer.addSublayer(gradientLayer)
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(startButton)
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    @objc private func startButtonTapped() {
        viewModel?.onboardingFinish()
    }
      
    private func setupConstraints() {
        
        let topInset: CGFloat
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                topInset = window.safeAreaInsets.top
            } else {
                topInset = 0
            }
        
        NSLayoutConstraint.activate([
            // Logo constraints
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: topInset + 40),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            // Welcome label constraints
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Welcome Text label constraints
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Start button constraints
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}
