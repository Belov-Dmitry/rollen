//
//  CartViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.10.2024.
//

import UIKit



class CartViewController: UIViewController {
    
    var viewModel: CartViewModel!
    
    // MARK: - UI Elements
    //private let topLabel = UILabel()
    private let topLineView = UIView()
    private let backgroundView = UIView()
    private let tableView = UITableView()
    private let purchaseTotalView = UIView()
    private let centerLineView = UIView()
    
    private let totalOrderLabel = ReusableLabel(text: "Стоимость заказа:", fontSize: 18, weight: .regular)
    
    private let totalOrderCostLabel = ReusableLabel(text: "0000", fontSize: 18, weight: .regular)
    private let promoCodeLabel = ReusableLabel(text: "Промокод:", fontSize: 18, weight: .regular)
    private let promoCodeTextField = UITextField()
    private let deliveryCostLabel = ReusableLabel(text: "Стоимость доставки:", fontSize: 18, weight: .regular)
    private let deliveryCost = ReusableLabel(text: "500", fontSize: 18, weight: .regular)
    
    private let backgroundFooterView = UIView()
    private let totalLabel = UILabel()
    private let totalCostLabel = UILabel()
    
    private let continueShoppingButton = UIButton()
    private let checkoutButton = RollButton(text: "Заказать", size: .small)
    private let bottomLineView = UIView()
        
    
    
    //MARK: - LifeCycle
    override func viewWillLayoutSubviews() {
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartViewModel()
        setupUI()
        setupConstraints()
        updateCosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchOrderedDishes()
        tableView.reloadData()
        updateCosts()
    }
}
//MARK: - Setting Views
extension CartViewController {
    private func setupLayout() {
        
        
        backgroundView.layer.masksToBounds = true
        backgroundView.layoutIfNeeded()
        backgroundView.backgroundColor = AppColors.Blue.light
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        let maskPath = UIBezierPath(
            roundedRect: backgroundView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 26, height: 26))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        backgroundView.layer.mask = maskLayer
        
        backgroundFooterView.layer.masksToBounds = true
        backgroundFooterView.layoutIfNeeded()
        let maskPathFooter = UIBezierPath(
            roundedRect: backgroundFooterView.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 26, height: 26))
        let maskLayerFooter = CAShapeLayer()
        maskLayerFooter.path = maskPathFooter.cgPath
        backgroundFooterView.layer.mask = maskLayerFooter
        backgroundFooterView.backgroundColor = AppColors.Red.light
        backgroundFooterView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUI() {
        view.backgroundColor = AppColors.tabbarBackground
        
        
        let titleText = "Корзина"
    
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 28),
            .foregroundColor: AppColors.Yellow.medium
        ]
        let attributedTitle = NSAttributedString(string: titleText, attributes: attributes)
        self.navigationItem.titleView = UILabel()
        let titleLabel = self.navigationItem.titleView as! UILabel
        titleLabel.attributedText = attributedTitle
        titleLabel.sizeToFit()
        
        
        
        
//        topLabel.translatesAutoresizingMaskIntoConstraints = false
//        topLabel.text = "Ваш заказ"
//        topLabel.textAlignment = .center
//        topLabel.textColor = AppColors.Yellow.dark
//        topLabel.font = .boldSystemFont(ofSize: 32)
//        
        topLineView.translatesAutoresizingMaskIntoConstraints = false
        topLineView.backgroundColor = AppColors.Red.light
        topLineView.layer.cornerRadius = 1
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppColors.Blue.light
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: String(describing: CartTableViewCell.self))
        
        purchaseTotalView.backgroundColor = AppColors.Blue.light
        purchaseTotalView.translatesAutoresizingMaskIntoConstraints = false
        
        centerLineView.translatesAutoresizingMaskIntoConstraints = false
        centerLineView.backgroundColor = AppColors.Red.light
        centerLineView.layer.cornerRadius = 1
        
        promoCodeLabel.textColor = AppColors.Red.dark
        
        promoCodeTextField.backgroundColor = AppColors.Blue.light
        promoCodeTextField.layer.borderWidth = 1
        promoCodeTextField.layer.borderColor = AppColors.Red.dark.cgColor
        promoCodeTextField.font = .boldSystemFont(ofSize: 16)
        promoCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        totalLabel.textColor = AppColors.Yellow.medium
        totalLabel.text = "Итого к оплате:"
        totalLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalCostLabel.textColor = AppColors.Yellow.medium
        //totalCostLabel.text = "$0.00"
        totalCostLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        totalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        continueShoppingButton.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.plain()
        config.imagePadding = 0
        config.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: -15, bottom: 2, trailing: 10)
        _ = UIButton(configuration: config, primaryAction: nil)
        continueShoppingButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        continueShoppingButton.tintColor = AppColors.Red.light
        continueShoppingButton.setTitle("Назад к выбору", for: .normal)
        continueShoppingButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        continueShoppingButton.setTitleColor(AppColors.Red.light, for: .normal)
        continueShoppingButton.addTarget(self, action: #selector(goBackToMenu), for: .touchUpInside)
        
        checkoutButton.addTarget(self, action: #selector(goToOrder), for: .touchUpInside)
       
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView.backgroundColor = AppColors.Blue.light.withAlphaComponent(0.3)
        bottomLineView.layer.cornerRadius = 1
            
        //view.addSubview(topLabel)
//        view.addSubview(topLineView)
//        view.addSubview(backgroundView)
//        view.addSubview(tableView)
//       
//        view.addSubview(purchaseTotalView)
//        view.addSubview(centerLineView)
//        view.addSubview(totalOrderLabel)
//        view.addSubview(totalOrderCostLabel)
//        view.addSubview(promoCodeLabel)
//        view.addSubview(promoCodeTextField)
//        view.addSubview(deliveryCostLabel)
//        view.addSubview(deliveryCost)
//        
//        view.addSubview(backgroundFooterView)
//        view.addSubview(totalLabel)
//        view.addSubview(totalCostLabel)
//        
//        view.addSubview(continueShoppingButton)
//        view.addSubview(checkoutButton)
//        view.addSubview(bottomLineView)
    }
}
//MARK: - Constraints



private extension CartViewController {
    func setupConstraints() {

        topLineView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        purchaseTotalView.translatesAutoresizingMaskIntoConstraints = false
        centerLineView.translatesAutoresizingMaskIntoConstraints = false
        totalOrderLabel.translatesAutoresizingMaskIntoConstraints = false
        totalOrderCostLabel.translatesAutoresizingMaskIntoConstraints = false
        promoCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        promoCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        deliveryCostLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryCost.translatesAutoresizingMaskIntoConstraints = false
        backgroundFooterView.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        continueShoppingButton.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topLineView)
        view.addSubview(backgroundView)
        view.addSubview(tableView)
        view.addSubview(purchaseTotalView)
        view.addSubview(centerLineView)
        view.addSubview(totalOrderLabel)
        view.addSubview(totalOrderCostLabel)
        view.addSubview(promoCodeLabel)
        view.addSubview(promoCodeTextField)
        view.addSubview(deliveryCostLabel)
        view.addSubview(deliveryCost)
        view.addSubview(backgroundFooterView)
        view.addSubview(totalLabel)
        view.addSubview(totalCostLabel)
        view.addSubview(continueShoppingButton)
        view.addSubview(checkoutButton)
        view.addSubview(bottomLineView)
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            topLineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLineView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            topLineView.heightAnchor.constraint(equalToConstant: 3),
            topLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 20),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backgroundView.heightAnchor.constraint(equalToConstant: 26),
            backgroundView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: purchaseTotalView.topAnchor),
            
            purchaseTotalView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            purchaseTotalView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            purchaseTotalView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            purchaseTotalView.heightAnchor.constraint(equalToConstant: 120),
            
            centerLineView.topAnchor.constraint(equalTo: purchaseTotalView.topAnchor),
            centerLineView.widthAnchor.constraint(equalTo: purchaseTotalView.widthAnchor, multiplier: 0.9),
            centerLineView.heightAnchor.constraint(equalToConstant: 3),
            centerLineView.centerXAnchor.constraint(equalTo: purchaseTotalView.centerXAnchor),
            
            totalOrderLabel.topAnchor.constraint(equalTo: centerLineView.bottomAnchor, constant: 12),
            totalOrderLabel.trailingAnchor.constraint(equalTo: purchaseTotalView.trailingAnchor, constant: -100),
            
            totalOrderCostLabel.centerYAnchor.constraint(equalTo: totalOrderLabel.centerYAnchor),
            totalOrderCostLabel.leadingAnchor.constraint(equalTo: totalOrderLabel.trailingAnchor, constant: 16),
            
            promoCodeLabel.topAnchor.constraint(equalTo: totalOrderLabel.bottomAnchor, constant: 15),
            promoCodeLabel.trailingAnchor.constraint(equalTo: purchaseTotalView.trailingAnchor, constant: -100),
            
            promoCodeTextField.centerYAnchor.constraint(equalTo: promoCodeLabel.centerYAnchor),
            promoCodeTextField.leadingAnchor.constraint(equalTo: promoCodeLabel.trailingAnchor, constant: 7),
            promoCodeTextField.heightAnchor.constraint(equalToConstant: 29),
            promoCodeTextField.widthAnchor.constraint(equalToConstant: 75),
            
            deliveryCostLabel.topAnchor.constraint(equalTo: promoCodeLabel.bottomAnchor, constant: 15),
            deliveryCostLabel.trailingAnchor.constraint(equalTo: purchaseTotalView.trailingAnchor, constant: -100),
            
            deliveryCost.centerYAnchor.constraint(equalTo: deliveryCostLabel.centerYAnchor),
            deliveryCost.leadingAnchor.constraint(equalTo: deliveryCostLabel.trailingAnchor, constant: 16),
            
            backgroundFooterView.topAnchor.constraint(equalTo: purchaseTotalView.bottomAnchor),
            backgroundFooterView.leadingAnchor.constraint(equalTo: purchaseTotalView.leadingAnchor),
            backgroundFooterView.trailingAnchor.constraint(equalTo: purchaseTotalView.trailingAnchor),
            backgroundFooterView.heightAnchor.constraint(equalToConstant: 30),
            
            totalLabel.centerYAnchor.constraint(equalTo: backgroundFooterView.centerYAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: backgroundFooterView.trailingAnchor, constant: -100),
            
            totalCostLabel.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor),
            totalCostLabel.centerXAnchor.constraint(equalTo: promoCodeTextField.centerXAnchor),
            
            continueShoppingButton.topAnchor.constraint(equalTo: backgroundFooterView.bottomAnchor, constant: 20),
            continueShoppingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueShoppingButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -10),
            
            checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: bottomLineView.topAnchor, constant: -10),
            
            bottomLineView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            bottomLineView.heightAnchor.constraint(equalToConstant: 3),
            bottomLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomLineView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
//}







//private extension CartViewController {
//    func setupConstraints() {
//        
//    
//        topLineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        topLineView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
//        topLineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
//        topLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        
//        backgroundView.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 20).isActive = true
//        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        backgroundView.heightAnchor.constraint(equalToConstant: 26).isActive = true
//        backgroundView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
//        
//        tableView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: purchaseTotalView.topAnchor).isActive = true
//        
//        purchaseTotalView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
//        purchaseTotalView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
//        purchaseTotalView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
//        purchaseTotalView.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        
//        centerLineView.topAnchor.constraint(equalTo: purchaseTotalView.topAnchor).isActive = true
//        centerLineView.widthAnchor.constraint(equalTo: purchaseTotalView.widthAnchor, multiplier: 0.9).isActive = true
//        centerLineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
//        centerLineView.centerXAnchor.constraint(equalTo: purchaseTotalView.centerXAnchor).isActive = true
//        
//        totalOrderLabel.topAnchor.constraint(equalTo: centerLineView.bottomAnchor, constant: 12).isActive = true
//        totalOrderLabel.trailingAnchor.constraint(equalTo: purchaseTotalView.trailingAnchor, constant: -100).isActive = true
//       
//        totalOrderCostLabel.centerYAnchor.constraint(equalTo: totalOrderLabel.centerYAnchor).isActive = true
//        totalOrderCostLabel.leadingAnchor.constraint(equalTo: totalOrderLabel.trailingAnchor, constant: 16).isActive = true
//        //totalOrderCostLabel.centerXAnchor.constraint(equalTo: promoCodeTextField.centerXAnchor).isActive = true
//        
//        promoCodeLabel.topAnchor.constraint(equalTo: totalOrderLabel.bottomAnchor, constant: 15).isActive = true
//        promoCodeLabel.trailingAnchor.constraint(equalTo: purchaseTotalView.trailingAnchor, constant: -100).isActive = true
//        
//        promoCodeTextField.centerYAnchor.constraint(equalTo: promoCodeLabel.centerYAnchor).isActive = true
//        promoCodeTextField.leadingAnchor.constraint(equalTo: promoCodeLabel.trailingAnchor, constant: 7).isActive = true
//        promoCodeTextField.heightAnchor.constraint(equalToConstant: 29).isActive = true
//        promoCodeTextField.widthAnchor.constraint(equalToConstant: 75).isActive = true
//        
//        deliveryCostLabel.topAnchor.constraint(equalTo: promoCodeLabel.bottomAnchor, constant: 15).isActive = true
//        deliveryCostLabel.trailingAnchor.constraint(equalTo: purchaseTotalView.trailingAnchor, constant: -100).isActive = true
//        
//        deliveryCost.centerYAnchor.constraint(equalTo: deliveryCostLabel.centerYAnchor).isActive = true
//        deliveryCost.leadingAnchor.constraint(equalTo: deliveryCostLabel.trailingAnchor, constant: 16).isActive = true
//        
//        backgroundFooterView.topAnchor.constraint(equalTo: purchaseTotalView.bottomAnchor).isActive = true
//        backgroundFooterView.leadingAnchor.constraint(equalTo: purchaseTotalView.leadingAnchor).isActive = true
//        backgroundFooterView.trailingAnchor.constraint(equalTo: purchaseTotalView.trailingAnchor).isActive = true
//        backgroundFooterView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        totalLabel.centerYAnchor.constraint(equalTo: backgroundFooterView.centerYAnchor).isActive = true
//        totalLabel.trailingAnchor.constraint(equalTo: backgroundFooterView.trailingAnchor, constant: -100).isActive = true
//        
//        totalCostLabel.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor).isActive = true
//        totalCostLabel.centerXAnchor.constraint(equalTo: promoCodeTextField.centerXAnchor).isActive = true
//        
//        continueShoppingButton.topAnchor.constraint(equalTo: backgroundFooterView.bottomAnchor, constant: 20).isActive = true
//        continueShoppingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        continueShoppingButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -10).isActive = true
//
//        
//        checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        checkoutButton.bottomAnchor.constraint(equalTo: bottomLineView.topAnchor, constant: -10).isActive = true
//        
//        bottomLineView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
//        bottomLineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
//        bottomLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        bottomLineView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//    }
    
    
    private func updateCosts() {
        totalOrderCostLabel.text = "\(viewModel.totalOrderCost)₽"
        deliveryCost.text = "\(viewModel.deliveryCost)₽"
        totalCostLabel.text = "\(viewModel.totalCost)₽"
    }
    
        @objc private func goBackToMenu() {
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 1
            }
        }
    
        @objc private func goToOrder() {
            // Переход на экран проверки заказа
            navigationController?.pushViewController(OrderReviewViewController(), animated: true)
        }
    
    
}
//MARK: - UITableViewDataSource, UITableViewDelegate
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("viewModel.orderedDishes.count \(viewModel.orderedDishes.count)")
        return viewModel.orderedDishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartTableViewCell.self), for: indexPath) as! CartTableViewCell
        let dish = viewModel.orderedDishes[indexPath.row]
                cell.configure(with: dish)
                cell.delegate = self
            return cell
    }
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = MenuOption.allCases[indexPath.row]
//        tableView.deselectRow(at: indexPath, animated: true)
//        delegate?.didSelect(menuItem: item)
    //}
}

extension CartViewController: CartTableViewCellDelegate {
    
    func cartTableViewCellDidUpdateQuantity(_ cell: CartTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let dish = viewModel.orderedDishes[indexPath.row]
            viewModel.addDish(dish)
            updateCosts()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}




//class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    var viewModel: CartViewModel!
//    
//    private let cartLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Корзина"
//        label.font = .boldSystemFont(ofSize: 24)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let dividerView1: UIView = {
//        let view = UIView()
//        view.backgroundColor = .lightGray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    
//    private let dividerView2: UIView = {
//        let view = UIView()
//        view.backgroundColor = .lightGray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let totalOrderLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Стоимость заказа:"
//        label.font = .systemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let totalOrderCostLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let deliveryCostLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Стоимость доставки:"
//        label.font = .systemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let deliveryCostValueLabel: UILabel = {
//        let label = UILabel()
//        label.text = "500₽"
//        label.font = .systemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let totalLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Итого к оплате:"
//        label.font = .boldSystemFont(ofSize: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let totalCostLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let blueView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.systemBlue
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("<- Вернуться в меню", for: .normal)
//        button.addTarget(self, action: #selector(goBackToMenu), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let orderButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Заказать", for: .normal)
//        button.addTarget(self, action: #selector(order), for: .touchUpInside)
//        button.backgroundColor = .red
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        viewModel = CartViewModel()
//        
//        setupUI()
//        setupConstraints()
//        tableView.dataSource = self
//        tableView.delegate = self
//        updateCosts()
//    }
//    
//    private func setupUI() {
//        view.addSubview(cartLabel)
//        view.addSubview(dividerView1)
//        view.addSubview(tableView)
//        view.addSubview(dividerView2)
//        view.addSubview(totalOrderLabel)
//        view.addSubview(totalOrderCostLabel)
//        view.addSubview(deliveryCostLabel)
//        view.addSubview(deliveryCostValueLabel)
//        view.addSubview(blueView)
//        blueView.addSubview(totalLabel)
//        blueView.addSubview(totalCostLabel)
//        view.addSubview(backButton)
//        view.addSubview(orderButton)
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            cartLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            cartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            dividerView1.topAnchor.constraint(equalTo: cartLabel.bottomAnchor, constant: 8),
//            dividerView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            dividerView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            dividerView1.heightAnchor.constraint(equalToConstant: 1),
//            
//            tableView.topAnchor.constraint(equalTo: dividerView1.bottomAnchor, constant: 8),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: dividerView2.topAnchor, constant: -8),
//            
//            dividerView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            dividerView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            dividerView2.heightAnchor.constraint(equalToConstant: 1),
//            
//            totalOrderLabel.topAnchor.constraint(equalTo: dividerView2.bottomAnchor, constant: 16),
//            totalOrderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            totalOrderCostLabel.centerYAnchor.constraint(equalTo: totalOrderLabel.centerYAnchor),
//            totalOrderCostLabel.leadingAnchor.constraint(equalTo: totalOrderLabel.trailingAnchor, constant: 8),
//            
//            deliveryCostLabel.topAnchor.constraint(equalTo: totalOrderLabel.bottomAnchor, constant: 16),
//            deliveryCostLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            deliveryCostValueLabel.centerYAnchor.constraint(equalTo: deliveryCostLabel.centerYAnchor),
//            deliveryCostValueLabel.leadingAnchor.constraint(equalTo: deliveryCostLabel.trailingAnchor, constant: 8),
//            
//            blueView.topAnchor.constraint(equalTo: deliveryCostLabel.bottomAnchor, constant: 16),
//            blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            
//            totalLabel.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 16),
//            totalLabel.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 16),
//            
//            totalCostLabel.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor),
//            totalCostLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: 8),
//            
//            blueView.bottomAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 16),
//            
//            backButton.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 16),
//            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            orderButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
//            orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            orderButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//    
//    private func updateCosts() {
//        totalOrderCostLabel.text = "\(viewModel.totalOrderCost)₽"
//        totalCostLabel.text = "\(viewModel.totalCost)₽"
//    }
//    
//    @objc private func goBackToMenu() {
//        if let tabBarController = self.tabBarController {
//            tabBarController.selectedIndex = 1
//        }
//    }
//    
//    @objc private func order() {
//        // Переход на экран проверки заказа
//        // navigationController?.pushViewController(OrderReviewViewController(), animated: true)
//    }
//    
//    // MARK: - UITableViewDataSource
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.orderedDishes.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
//        let dish = viewModel.orderedDishes[indexPath.row]
//        cell.configure(with: dish)
//        cell.delegate = self
//        return cell
//    }
//}
//
//extension CartViewController: CartTableViewCellDelegate {
//    
//    func cartTableViewCellDidUpdateQuantity(_ cell: CartTableViewCell) {
//        if let indexPath = tableView.indexPath(for: cell) {
//            let dish = viewModel.orderedDishes[indexPath.row]
//            viewModel.addDish(dish)
//            updateCosts()
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
//    }
//}
