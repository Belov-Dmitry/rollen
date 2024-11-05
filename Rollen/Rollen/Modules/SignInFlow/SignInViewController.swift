//
//  SignInViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.10.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    var viewModel: (SignInFinishDelegate)?

    
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
        setupUI()
    }

    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .red
    }
}
