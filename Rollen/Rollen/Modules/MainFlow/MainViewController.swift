//
//  MainViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.10.2024.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    var viewModel = MainViewModel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let topLabel: UILabel = {
        let element = UILabel()
        element.text = "Menu"
        element.textAlignment = .center
        element.textColor = .accentYellow
        element.font = .boldSystemFont(ofSize: 32)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.text = "Еда, приготовленная с любовью!"
        element.textAlignment = .center
        element.textColor = .accentLightRed
        element.font = .boldSystemFont(ofSize: 17)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let searchField = SearchMenuField()
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let goToTopButton = RollButton(text: "Вернись наверх!", size: .large)
    
    
    //    // MARK: - init
    //    init(viewModel: MainViewModel) {
    //        super.init(nibName: nil, bundle: nil)
    //        self.viewModel = viewModel
    //        self.viewModel.makeDishTypeArray()
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        //setupConstraints()
        addAction()
        configureScrollView()
        setupLayout()
    }
    
    private func setupUI() {
        navigationController?.tabBarController?.tabBar.isTranslucent = false
        navigationController?.tabBarController?.tabBar.barTintColor = AppColors.tabbarBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        view.backgroundColor = AppColors.MainMenuBackgroundColor
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(searchField)
        contentView.addSubview(collectionView)
        contentView.addSubview(goToTopButton)
        
        
    }
    
    private func setupCollectionView() {
        print(#function)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = AppColors.MainMenuBackgroundColor
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self))
    }
    
//    private func setupConstraints() {
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        
//    }
    func addAction() {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageName.sideMenuButtonImage), style: .done, target: self, action: #selector(selectMenuTapped))
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageName.busketButtonImage), style: .done, target: self, action: #selector(selectBasketTapped))
            
        goToTopButton.addTarget(self, action: #selector(selectMyButtonTapped), for: .touchUpInside)
        }
        
        @objc func selectMyButtonTapped() {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
        @objc func selectMenuTapped() {
            print("tapped")
            //delegate?.didSelectMenuItem()
        }
        
        @objc func selectBasketTapped() {
            let viewControllerToPresent = ViewController()
            viewControllerToPresent.modalPresentationStyle = .fullScreen
            present(viewControllerToPresent, animated: true, completion: nil)
        }
    func configureScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.showsVerticalScrollIndicator = true
            scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = AppColors.tabbarBackground
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.backgroundColor = AppColors.tabbarBackground
        }

}

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dishTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
        cell.configure(with: viewModel.dishTypeArray[indexPath.item])
        cell.backgroundColor = AppColors.MainMenuCellBackgroundColor
        return cell }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: width * 0.7)
    }
}

private extension MainMenuViewController {
    func setupLayout() {
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        topLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        searchField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        searchField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        
        goToTopButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        goToTopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goToTopButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        goToTopButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
}
