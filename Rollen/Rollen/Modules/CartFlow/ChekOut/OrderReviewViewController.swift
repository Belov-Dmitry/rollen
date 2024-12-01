//
//  OrderReviewViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 01.12.2024.
//


import UIKit

class OrderReviewViewController: UIViewController, UITableViewDataSource {
    
    var viewModel: OrderReviewViewModel!
    var cartViewModel: CartViewModel!
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Проверка заказа"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = AppColors.Yellow.light
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderReviewTableViewCell.self, forCellReuseIdentifier: "OrderReviewTableViewCell")
        tableView.backgroundColor = AppColors.Blue.medium
        tableView.layer.borderColor = AppColors.Blue.dark.cgColor
        tableView.layer.borderWidth = 1
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let totalOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Общая стоимость:"
        label.font = .systemFont(ofSize: 18)
        label.textColor = AppColors.Yellow.light
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalOrderCostLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = AppColors.Yellow.medium
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deliveryMethodLabel: UILabel = {
        let label = UILabel()
        label.text = "Способ доставки:"
        label.font = .systemFont(ofSize: 18)
        label.textColor = AppColors.Yellow.light
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deliveryMethodSwitch: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Самовывоз", "Доставка"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = AppColors.Red.light
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: AppColors.Yellow.medium], for: .selected)
        segmentedControl.layer.borderColor = AppColors.Red.medium.cgColor
        segmentedControl.layer.borderWidth = 1
        segmentedControl.addTarget(self, action: #selector(deliveryMethodChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    
    private let addressTextField = RegisterTextField(placeholder: "Введите адрес доставки")
    
    private let restaurantAddressLabel = RegisterTextField(placeholder: "Ленина 125, Ростов-на-Дону")
    
    private let orderButton = RollButton(text: "Заказать", size: .large)
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel = OrderReviewViewModel()
        setupUI()
        setupConstraints()
        tableView.dataSource = self
        updateCosts()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    private func setupUI() {
        navigationController?.navigationBar.tintColor = AppColors.Red.medium
        view.backgroundColor = AppColors.Blue.medium
        addressTextField.isHidden = true // Скрыть поле ввода по умолчанию
        addressTextField.backgroundColor = AppColors.Red.lightTransparent
        
        restaurantAddressLabel.backgroundColor = AppColors.Red.lightTransparent
        restaurantAddressLabel.isUserInteractionEnabled = false
        
        orderButton.addTarget(self, action: #selector(order), for: .touchUpInside)
        
        
        view.addSubview(orderLabel)
        view.addSubview(tableView)
        view.addSubview(totalOrderLabel)
        view.addSubview(totalOrderCostLabel)
        view.addSubview(deliveryMethodLabel)
        view.addSubview(deliveryMethodSwitch)
        view.addSubview(addressTextField)
        view.addSubview(restaurantAddressLabel)
        view.addSubview(orderButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            orderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            orderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 200),
            
            totalOrderLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            totalOrderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            totalOrderCostLabel.centerYAnchor.constraint(equalTo: totalOrderLabel.centerYAnchor),
            totalOrderCostLabel.leadingAnchor.constraint(equalTo: totalOrderLabel.trailingAnchor, constant: 8),
            
            deliveryMethodLabel.topAnchor.constraint(equalTo: totalOrderLabel.bottomAnchor, constant: 16),
            deliveryMethodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            deliveryMethodSwitch.topAnchor.constraint(equalTo: deliveryMethodLabel.bottomAnchor, constant: 8),
            deliveryMethodSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deliveryMethodSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            addressTextField.topAnchor.constraint(equalTo: deliveryMethodSwitch.bottomAnchor, constant: 16),
            addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            restaurantAddressLabel.centerYAnchor.constraint(equalTo: addressTextField.centerYAnchor),
            restaurantAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            restaurantAddressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            orderButton.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 16),
            orderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            let bottomSpace = view.frame.height - (orderButton.frame.origin.y + orderButton.frame.height)
            let offset = keyboardHeight - bottomSpace + 20
            if offset > 0 {
                view.frame.origin.y = -offset
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    
    private func updateCosts() {
        totalOrderCostLabel.text = "\(viewModel.totalOrderCost)₽"
    }
    
    @objc private func deliveryMethodChanged(_ sender: UISegmentedControl) {
        let isDelivery = sender.selectedSegmentIndex == 1
        addressTextField.isHidden = !isDelivery
        restaurantAddressLabel.isHidden = isDelivery
    }
    
    @objc private func order() {
        let deliveryMethod = deliveryMethodSwitch.selectedSegmentIndex
        let deliveryAddress = addressTextField.text

        let orderDetails = viewModel.getOrderDetails(deliveryMethod: deliveryMethod, deliveryAddress: deliveryAddress)

        // Печатаем текст в консоль
        print(orderDetails)

        // Поделиться списком через UIActivityViewController
        let activityViewController = UIActivityViewController(activityItems: [orderDetails], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)

        // Переход на экран оплаты
        // navigationController?.pushViewController(PaymentViewController(), animated: true)
    }



    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderedDishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderReviewTableViewCell", for: indexPath) as! OrderReviewTableViewCell
        let dish = viewModel.orderedDishes[indexPath.row]
        cell.configure(with: dish)
        return cell
    }
}
