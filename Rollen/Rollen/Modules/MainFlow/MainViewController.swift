//
//  MainViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.10.2024.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    var viewModel = MainViewModel()
    private var isShowingDishes = false
    private var selectedDishType: String? = nil
    
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
        element.textColor = AppColors.Blue.light
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
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        addAction()
        configureScrollView()
        setupConstraints()
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = AppColors.MainMenuBackgroundColor
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self))
        collectionView.register(DishCell.self, forCellWithReuseIdentifier: String(describing: DishCell.self))
    }
    
    func addAction() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageName.sideMenuButtonImage),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(selectMenuTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "basket"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(selectBasketTapped))
        
        goToTopButton.addTarget(self, action: #selector(goToTop), for: .touchUpInside)
    }
    
    @objc func goToTop() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func selectMenuTapped() {
        showSideMenu()
    }
    
    @objc func selectBasketTapped() {
        print("basket pressed")
        tabBarController?.selectedIndex = 0
        
    }
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = AppColors.tabbarBackground
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = AppColors.tabbarBackground
    }
    
    private func updateContent() {
        if isShowingDishes, let dishType = selectedDishType {
            topLabel.text = dishType
            titleLabel.text = "Выберите блюдо"
            viewModel.filterDishes(by: dishType)
        } else {
            topLabel.text = "Menu"
            titleLabel.text = "Еда, приготовленная с любовью!"
            viewModel.filteredDishes = []
        }
        collectionView.reloadData()
    }
    
    @objc private func backToDishTypes() {
        isShowingDishes = false
        selectedDishType = nil
        updateContent()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageName.sideMenuButtonImage),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(selectMenuTapped))
    }
    
}
//MARK: - SideMenuViewControllerDelegate
extension MainMenuViewController: SideMenuViewControllerDelegate {
    func didSelect(menuItem: SideMenuViewController.MenuOption) {
        switch menuItem {
        case .profile:
            tabBarController?.selectedIndex = 0
        case .wishlist:
            print("Wishlist selected")
        case .loyaltyPoints:
            print("Loyalty Points selected")
        case .paymentMethods:
            print("Payment Methods selected") } }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isShowingDishes ? viewModel.filteredDishes.count : viewModel.dishTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isShowingDishes {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DishCell.self), for: indexPath) as! DishCell
            cell.configure(with: viewModel.filteredDishes[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
            cell.configure(with: viewModel.dishTypeArray[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        if isShowingDishes {
            return CGSize(width: width, height: width * 0.4)
        } else {
            return CGSize(width: width, height: width * 0.7)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isShowingDishes {
            let selectedDish = viewModel.filteredDishes[indexPath.item]
            let detailsViewModel = DetailsViewModel(dish: selectedDish)
            let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
            detailsViewController.modalPresentationStyle = .overFullScreen
            detailsViewController.modalTransitionStyle = .crossDissolve
            present(detailsViewController, animated: true, completion: nil)
        } else {
            let dishType = viewModel.dishTypeArray[indexPath.item]
            selectedDishType = dishType.dishTypeName
            isShowingDishes = true
            updateContent()
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backToDishTypes))
        }
    }
}

//MARK: - Show SideMenu
private extension MainMenuViewController {
    
    func showSideMenu() {
        let sideMenuViewController = SideMenuViewController()
        sideMenuViewController.delegate = self
        sideMenuViewController.modalPresentationStyle = .overFullScreen
        sideMenuViewController.modalTransitionStyle = .flipHorizontal
        present(sideMenuViewController, animated: true, completion: nil)
    }
}

//MARK: - Setup Constraints
private extension MainMenuViewController {
    func setupConstraints() {
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
        goToTopButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
}
