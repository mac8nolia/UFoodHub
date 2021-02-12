//
//  FoodWeightViewController.swift
//  Ufood
//
//  Created by Ольга on 17.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

typealias CompletionBlock = (_ weightToReturn: Int) -> () // string ???

class FoodWeightViewController: UIViewController {
    
    private var presenter: FoodWeightViewOutput!
    
    /**
     Allows to choose food's portions from base
     */
    private var portionsPicker: UIPickerView!
    
    /**
     Allows to choose quantity of portions
     */
    private var quantityStepper: UIStepper!
    
    /**
     Shows current quantity of portions
     */
    private var stepperNumberLabel: UILabel!
    
    /**
     Shows current resulting weight of food
     */
    private var resultingWeightLabel: UILabel!
    
    /**
     Constraints for view's represence in portrait orientation
     */
    private var portraitConstraints = [NSLayoutConstraint]()
    
    /**
     Constraints for view's represence in landscape orientation
     */
    private var landscapeConstraints = [NSLayoutConstraint]()
    
    /**
     Completion block, that returns resulting weight of the food to the FoodViewController
     */
    var completionBlock: CompletionBlock?
    
    static func createWith(presenter: FoodWeightViewOutput) -> FoodWeightViewController {
        let vc = FoodWeightViewController()
        vc.presenter = presenter
        return vc
    }
    
// MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(view: self)
        // Call presenter for next setup
        presenter.loadViewData()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.upgradeGradientBackground()
        if self.view.bounds.height > self.view.bounds.width {
            NSLayoutConstraint.deactivate(self.landscapeConstraints)
            NSLayoutConstraint.activate(self.portraitConstraints)
        } else {
            NSLayoutConstraint.deactivate(self.portraitConstraints)
            NSLayoutConstraint.activate(self.landscapeConstraints)
        }
    }
}

// MARK: - Food Weight Presenter Output

extension FoodWeightViewController: FoodWeightPresenterOutput {
    
    func showPicker() {
        let picker = UIPickerView()
        picker.delegate = self
        self.portionsPicker = picker
    }
    
    func showStepperWith(defaultNumber: String, maximumValue: Double, currentValue: Double) {
        let stepper = UIStepper()
        stepper.maximumValue = maximumValue
        stepper.value = currentValue
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        self.quantityStepper = stepper
        
        let label = UILabel()
        label.styleMediumCenterWith(text: defaultNumber)
        self.stepperNumberLabel = label
    }
    
    func show(resultingWeight: String) {
        let label = UILabel()
        label.styleMediumCenterWith(text: resultingWeight)
        self.resultingWeightLabel = label
    }

    func change(stepperNumber: String) {
        stepperNumberLabel.text = stepperNumber
    }
    
    func change(resultingWeight: String) {
        resultingWeightLabel.text = resultingWeight
    }
}

// MARK: - Picker View Data Source, Picker View Delegate

extension FoodWeightViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return presenter.numberOfComponentsInPicker()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.numberOfRowsIn(pickerComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = presenter.titleFor(row: row, forPickerComponent: component)
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: AppColor.darkBlueShade])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.changed(pickerRow: row) 
    }
}

// MARK: - Setup and layout of view

extension FoodWeightViewController {
    
    func setupView() {
        view.setGradientBackground(colorTop: AppColor.whiteShade, colorBottom: AppColor.yellowShade)
        
        // Create subviews that will be placed in different ways relative to each other for different orientations: top-bottom in the portrait; left-right in the landscape
        let topLeftView = createTopLeftView()
        let bottomRightView = createBottomRightView()
        
        // Add subviews and set common constrains for both them
        topLeftView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topLeftView)
        bottomRightView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomRightView)
        
        NSLayoutConstraint.activate([
            topLeftView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLeftView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomRightView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomRightView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Create constraints for portrait orientation
        let c1Port = topLeftView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let c2Port = topLeftView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        let c3Port = bottomRightView.topAnchor.constraint(equalTo: topLeftView.bottomAnchor)
        let c4Port = bottomRightView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        
        // Create constraints for landscape orientation
        let c1Land = topLeftView.trailingAnchor.constraint(equalTo: view.centerXAnchor)
        let c2Land = topLeftView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let c3Land = bottomRightView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let c4Land = bottomRightView.leadingAnchor.constraint(equalTo: topLeftView.trailingAnchor)
        
        // Add constraints to appropriate arrays
        portraitConstraints += [c1Port, c2Port, c3Port, c4Port]
        landscapeConstraints += [c1Land, c2Land, c3Land, c4Land]
    }
    
    func createTopLeftView() -> UIView {
        let view = UIView()
        
        // Setup of stepper
        quantityStepper.tintColor = .darkGray
        quantityStepper.backgroundColor = AppColor.lightBlueShade
        
        // Create additional labels
        let totalLabel = UILabel()
        totalLabel.styleMediumCenterWith(text: "Итого:") // or "Total:"
        let gramLabel = UILabel()
        gramLabel.styleMediumCenterWith(text: "г") // or "g"
        let numberLabel = UILabel()
        numberLabel.styleMediumCenterWith(text: "Количество:") // or "Number:"
        let pieceLabel = UILabel()
        pieceLabel.styleMediumCenterWith(text: "шт.") // or "pc."
        
        // Add and layout of subviews
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalLabel)
        gramLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gramLabel)
        resultingWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultingWeightLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberLabel)
        pieceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pieceLabel)
        stepperNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepperNumberLabel)
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityStepper)
        NSLayoutConstraint.activate([
            
            // X axis
            totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultingWeightLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            gramLabel.leadingAnchor.constraint(equalTo: resultingWeightLabel.trailingAnchor, constant: 10),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepperNumberLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            pieceLabel.leadingAnchor.constraint(equalTo: stepperNumberLabel.trailingAnchor, constant: 10),
            quantityStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Y axis
            numberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberLabel.topAnchor.constraint(equalTo: resultingWeightLabel.bottomAnchor, constant: 20),
            gramLabel.bottomAnchor.constraint(equalTo: resultingWeightLabel.bottomAnchor),
            resultingWeightLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 10),
            stepperNumberLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
            pieceLabel.bottomAnchor.constraint(equalTo: stepperNumberLabel.bottomAnchor),
            quantityStepper.topAnchor.constraint(equalTo: stepperNumberLabel.bottomAnchor, constant: 15)
        ])
        return view
    }
    
    func createBottomRightView() -> UIView {
        let view = UIView()
        
        // Create additional labels and buttons
        let pickerLabel = UILabel()
        pickerLabel.styleMediumCenterWith(text: "Выберите порцию:") // or "Choose portion:"
        let doneButton = UIButton()
        doneButton.styleActionWith(title: "Готово", color: AppColor.lightBlueShade)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        let cancelButton = UIButton()
        cancelButton.styleActionWith(title: "Отмена", color: AppColor.redShade)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
        // Add and layout of subviews
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        pickerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerLabel)
        portionsPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(portionsPicker)
        NSLayoutConstraint.activate([
            
            // X axis
            pickerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            portionsPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            portionsPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doneButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            doneButton.widthAnchor.constraint(equalToConstant: 120),
            doneButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalTo: doneButton.widthAnchor),
            
            // Y axis
            portionsPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            portionsPicker.heightAnchor.constraint(equalToConstant: 120),
            portionsPicker.topAnchor.constraint(equalTo: pickerLabel.bottomAnchor, constant: 10),
            doneButton.topAnchor.constraint(equalTo: portionsPicker.bottomAnchor, constant: 20),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.topAnchor.constraint(equalTo: doneButton.topAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor)
        ])
        return view
    }
}

// MARK: - Actions handler

extension FoodWeightViewController {
    
    @objc func stepperChanged(sender: UIStepper) {
        presenter.changed(stepperValue: Int(sender.value))
    }
    
    @objc func cancelButtonAction(sender: UIButton!) {
        sender.pressAnimation(){_ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func doneButtonAction(sender: UIButton!) {
        sender.pressAnimation(){_ in
            // Call completion block with resulting weight
            guard let cb = self.completionBlock else { return }
            cb(self.presenter.resultingWeight)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
