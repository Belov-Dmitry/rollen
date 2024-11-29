//
//  DetailsViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.11.2024.
//


import UIKit

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModel!
    
    private let imageView = UIImageView()
    private let typeLabelView = UIView()
    private let typeLabel = UILabel()
    private let detailsView = UIView()
    private let descriptionLabel = UILabel()
    private let detailDescriptionLabel = UILabel()
    private let ingredientsLabel = UILabel()
    private let ingredientsCollectionView: UICollectionView
    private let addOnsLabel = UILabel()
    private let addOnsPicker = UIPickerView()
    private let addOnsTextField = UITextField()
    private let orderView = UIView()
    private let priceLabel = UILabel()
    private let quantityControl = UIStackView()
    private let minusButton = UIButton()
    private let quantityLabel = UILabel()
    private let plusButton = UIButton()
    private let addToCartButton = UIButton()
    private let closeButton = UIButton(type: .system)
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        ingredientsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureUI()
        updatePrice()
        setupPickerToolbar()
        
        // Скрытие клавиатуры при касании за пределами текстовых полей
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    func setupPickerToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        addOnsTextField.inputAccessoryView = toolbar
    }
    
    @objc func donePicker() {
        view.endEditing(true)
    }
    
    
    private func setupUI() {
        view.backgroundColor = AppColors.Blue.light
        
        //  closeButton.setTitle("<", for: .normal)
//        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .bold)
//        closeButton.setTitleColor(AppColors.Red.medium, for: .normal)
        
        closeButton.setImage(UIImage(named: ImageName.backButtonImage), for: .normal)
        closeButton.tintColor = .white
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        closeButton.layer.cornerRadius = 10
        closeButton.layer.borderColor = UIColor.white.cgColor
        closeButton.layer.borderWidth = 1
        closeButton.addTarget(self, action: #selector(closeDetails), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        typeLabelView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        typeLabelView.layer.cornerRadius = 10
        typeLabelView.layer.borderWidth = 1
        typeLabelView.layer.borderColor = UIColor.white.cgColor
        typeLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        
        typeLabel.font = .boldSystemFont(ofSize: 20)
        typeLabel.textColor = .white
        typeLabel.textAlignment = .center
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        detailsView.backgroundColor = AppColors.Blue.dark
        detailsView.layer.cornerRadius = 25
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        
        descriptionLabel.text = "Описание"
        descriptionLabel.font = .boldSystemFont(ofSize: 20)
        descriptionLabel.textColor = AppColors.dishesDetailsTextColor
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailDescriptionLabel.text = "Тут будет вкусное описание возможно другим цветом"
        detailDescriptionLabel.numberOfLines = 2
        detailDescriptionLabel.font = .boldSystemFont(ofSize: 16)
        detailDescriptionLabel.textColor = AppColors.dishesDetailsTextColor
        detailDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsLabel.text = "Ингридиенты:"
        ingredientsLabel.font = .boldSystemFont(ofSize: 20)
        ingredientsLabel.textColor = AppColors.dishesDetailsTextColor
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        ingredientsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ingredientCell")
        ingredientsCollectionView.backgroundColor = .clear
        ingredientsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addOnsLabel.text = "Добавки:"
        addOnsLabel.font = .boldSystemFont(ofSize: 20)
        addOnsLabel.textColor = AppColors.dishesDetailsTextColor
        addOnsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addOnsPicker.dataSource = self
        addOnsPicker.delegate = self
        addOnsPicker.translatesAutoresizingMaskIntoConstraints = false
        
        addOnsTextField.tintColor = AppColors.Blue.light
        addOnsTextField.attributedPlaceholder = NSAttributedString(string: "Выберите добавки", attributes: [.foregroundColor: AppColors.Blue.light.withAlphaComponent(0.5)])
        addOnsTextField.layer.cornerRadius = 18
        addOnsTextField.layer.borderWidth = 1
        addOnsTextField.layer.borderColor = AppColors.Blue.light.cgColor

        // Настройка для leftView
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: addOnsTextField.frame.height))
        addOnsTextField.leftView = leftPaddingView
        addOnsTextField.leftViewMode = .always

        // Настройка для rightView
        let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        arrowImageView.contentMode = .scaleAspectFit

        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: addOnsTextField.frame.height))
        rightPaddingView.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: rightPaddingView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: rightPaddingView.trailingAnchor, constant: -10),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])

        addOnsTextField.rightView = rightPaddingView
        addOnsTextField.rightViewMode = .always
        addOnsTextField.inputView = addOnsPicker
        addOnsTextField.translatesAutoresizingMaskIntoConstraints = false


        
        
        orderView.layer.cornerRadius = 25
        orderView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        orderView.translatesAutoresizingMaskIntoConstraints = false
        
        
        priceLabel.textColor = .white
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        quantityControl.axis = .horizontal
        quantityControl.alignment = .center
        quantityControl.distribution = .equalSpacing
        quantityControl.layer.borderColor = UIColor.white.cgColor
        quantityControl.layer.borderWidth = 1
        quantityControl.layer.cornerRadius = 25
        quantityControl.translatesAutoresizingMaskIntoConstraints = false
        
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        minusButton.setTitleColor(.white, for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        minusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        
        quantityLabel.textColor = .white
        quantityLabel.text = "1"
        quantityLabel.font = UIFont.boldSystemFont(ofSize: 20)
        quantityLabel.textAlignment = .center
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        
        quantityControl.addArrangedSubview(minusButton)
        quantityControl.addArrangedSubview(quantityLabel)
        quantityControl.addArrangedSubview(plusButton)
        
        
        let cartImage = UIImage(named: "detailsBasket")
        addToCartButton.setImage(cartImage, for: .normal)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
    }
    // MARK: - setupConstraints
    private func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
        view.addSubview(typeLabelView)
        view.addSubview(typeLabel)
        view.addSubview(detailsView)
        detailsView.addSubview(descriptionLabel)
        detailsView.addSubview(detailDescriptionLabel)
        detailsView.addSubview(ingredientsLabel)
        detailsView.addSubview(ingredientsCollectionView)
        detailsView.addSubview(addOnsLabel)
        detailsView.addSubview(addOnsTextField) // Уберем addOnsPicker
        view.addSubview(orderView)
        orderView.addSubview(priceLabel)
        orderView.addSubview(quantityControl)
        orderView.addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 80),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            typeLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            typeLabel.heightAnchor.constraint(equalTo: closeButton.heightAnchor),
            
            typeLabelView.topAnchor.constraint(equalTo: closeButton.topAnchor),
            typeLabelView.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 8),
            typeLabelView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor, constant: -8),
            typeLabelView.heightAnchor.constraint(equalToConstant: 40),
            
            // Details view constraints
            detailsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 16),
            
            detailDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            detailDescriptionLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 16),
            detailDescriptionLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -16),
            
            ingredientsLabel.topAnchor.constraint(equalTo: detailDescriptionLabel.bottomAnchor, constant: 16),
            ingredientsLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 16),
            
            ingredientsCollectionView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 16),
            ingredientsCollectionView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 16),
            ingredientsCollectionView.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -16),
            ingredientsCollectionView.heightAnchor.constraint(equalToConstant: 70),
            
            addOnsLabel.topAnchor.constraint(equalTo: ingredientsCollectionView.bottomAnchor, constant: 16),
            addOnsLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 16),
            addOnsLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -16),
            
            addOnsTextField.topAnchor.constraint(equalTo: addOnsLabel.bottomAnchor, constant: 16),
            addOnsTextField.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 16),
            addOnsTextField.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -16),
            addOnsTextField.heightAnchor.constraint(equalToConstant: 40),
            
            orderView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 16),
            orderView.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -16),
            orderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            orderView.heightAnchor.constraint(equalToConstant: 60),
            
            priceLabel.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 23),
            priceLabel.centerYAnchor.constraint(equalTo: orderView.centerYAnchor),
            
            quantityControl.centerXAnchor.constraint(equalTo: orderView.centerXAnchor),
            quantityControl.centerYAnchor.constraint(equalTo: orderView.centerYAnchor),
            
            addToCartButton.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -10),
            addToCartButton.centerYAnchor.constraint(equalTo: orderView.centerYAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 40),
            addToCartButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func configureUI() {
        imageView.image = UIImage(named: viewModel.selectedDish.imagename)
        typeLabel.text = viewModel.selectedDish.type
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func closeDetails() {
        dismiss(animated: true, completion: nil)
    }
    
    // Добавление в корзину
    @objc private func addToCart() {
        guard let quantity = Int(quantityLabel.text ?? "0") else { return }
        viewModel.addDishToOrder(quantity: quantity)
        print("Added \(viewModel.selectedDish.name) to order with quantity \(quantity).")
    }

    // Увеличение количества
    @objc private func increaseQuantity() {
        guard let currentQuantity = Int(quantityLabel.text ?? "0") else { return }
        let newQuantity = currentQuantity + 1
        quantityLabel.text = "\(newQuantity)"
        updatePrice()
    }

    // Уменьшение количества
    @objc private func decreaseQuantity() {
        guard let currentQuantity = Int(quantityLabel.text ?? "1"), currentQuantity > 1 else { return }
        let newQuantity = currentQuantity - 1
        quantityLabel.text = "\(newQuantity)"
        updatePrice()
    }

    // Обновление цены
    private func updatePrice() {
        guard let quantity = Int(quantityLabel.text ?? "0") else { return }
        let totalPrice = viewModel.selectedDish.price * quantity
        priceLabel.text = "\(totalPrice)₽"
    }

}
//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension DetailsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.addOns.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let addOn = viewModel.addOns[row]
        return "\(addOn.name) - \(addOn.price)₽"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let addOn = viewModel.addOns[row]
        if viewModel.selectedAddOns.contains(where: { $0.name == addOn.name }) {
            viewModel.deselectAddOn(addOn)
        } else {
            viewModel.selectAddOn(addOn)
        }
        updatePrice()
    }
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ingredientImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientCell", for: indexPath)
        
        let imageName = viewModel.ingredientImages[indexPath.item]
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50) ])
        
        return cell
    }
}
