//
//  MiddleHeaderView.swift
//  Ufood
//
//  Created by Ольга on 07.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class MiddleHeaderView: VerticalGradientCornerView {

    private weak var homeController: FoodViewController!

    /**
     Text field for user's enter of portion's quantity
     */
    private let quantityTextfield =  UITextField()
    
    init(quantity: String, homeController: FoodViewController){
        self.quantityTextfield.text = quantity
        self.homeController = homeController
        super.init(corners: [.bottomLeft,.bottomRight], radius: 90, topColor: AppColor.darkBlueShade, bottomColor: AppColor.whiteShade)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeQuantityTextField(text: String) {
        quantityTextfield.text = text
    }
}

// MARK: - Setup view

extension MiddleHeaderView {
    
    private func setupView() {
        
        // Create quantity label
        let quantityLabel = UILabel()
        quantityLabel.styleMediumCenterWith(text: "Введите кол-во, г") // or "Enter quantity, g"
        quantityLabel.numberOfLines = 2

        // Setup text field for enter of quantity
        quantityTextfield.delegate = self
        quantityTextfield.font = AppFont.defaultRegularFont(size: 17)
        quantityTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        quantityTextfield.autocorrectionType = UITextAutocorrectionType.no
        quantityTextfield.keyboardType = UIKeyboardType.decimalPad
        quantityTextfield.clearButtonMode = UITextField.ViewMode.always
        quantityTextfield.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        // Add buttons "Done" and "Cancel" on decimal keyboard
        addButtonsOnKeyboard()
        
        // Create button, that calls food weight's view
        let quantityHelperButton = UIButton()
        quantityHelperButton.setImage(UIImage(named: "helperButton"), for: .normal)
        quantityHelperButton.addTarget(self, action: #selector(quantityHelperButtonAction), for: .touchUpInside)
        
        // Add and layout of subviews
        self.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(quantityLabel)
        quantityTextfield.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(quantityTextfield)
        quantityHelperButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(quantityHelperButton)
        NSLayoutConstraint.activate([
            
            // X axis
            quantityLabel.widthAnchor.constraint(equalToConstant: 90),
            quantityTextfield.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 10),
            quantityTextfield.widthAnchor.constraint(equalToConstant: 90),
            quantityHelperButton.leadingAnchor.constraint(equalTo: quantityTextfield.trailingAnchor, constant: 20),
            quantityHelperButton.widthAnchor.constraint(equalToConstant: 30),
            
            // Y axis
            quantityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 130),
            self.bottomAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 30),
            quantityTextfield.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            quantityHelperButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            quantityHelperButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Align group of subviews horizontally
        let dimensionLeft = self.leadingAnchor.anchorWithOffset(to: quantityLabel.leadingAnchor)
        let dimensionRight = quantityHelperButton.trailingAnchor.anchorWithOffset(to: self.trailingAnchor)
        dimensionLeft.constraint(equalTo: dimensionRight).isActive = true
    }
    
    func addButtonsOnKeyboard() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = AppColor.yellowShade
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(onClickDoneButton)) // or "Done"
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(onClickCancelButton)) // or "Cancel"
        doneButton.tintColor = .black
        cancelButton.tintColor = .black
        toolBar.setItems([cancelButton, space, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        quantityTextfield.inputAccessoryView = toolBar
    }
}

// MARK: - Text field delegate

extension MiddleHeaderView: UITextFieldDelegate {
    
    /**
     Helps to restrict type and number of entering by user characters
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        // Only decimal
        let numberCharSet = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard numberCharSet.isSuperset(of: characterSet) else { return false }
        // Max 4 characters
        let newLength = text.count + string.count - range.length
        return newLength > 4 ? false : true
    }
}

// MARK: - Actions handler

extension MiddleHeaderView {
    
    /**
     Reports to the view controller, that user entered quantity, and passes the text
     */
    @objc func onClickDoneButton() {
        quantityTextfield.resignFirstResponder()
        let text = quantityTextfield.text ?? ""
        homeController.quantityTextFieldDoneAction(text: text)
    }

    @objc func onClickCancelButton() {
        quantityTextfield.resignFirstResponder()
    }
    
    /**
     Reports to the view controller, that user taps to quantity helper button
     */
    @objc func quantityHelperButtonAction(sender: UIButton!) {
        sender.pressAnimation(){_ in
            self.homeController.quantityHelperButtonAction()
        }
    }
}
