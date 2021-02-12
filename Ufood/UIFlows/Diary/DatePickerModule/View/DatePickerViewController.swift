//
//  DatePickerViewController.swift
//  Ufood
//
//  Created by Ольга on 13.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

typealias CompletionBlockDate = (_ infoToReturn: Date) -> () 

class DatePickerViewController: UIViewController {
    
    private var presenter: DatePickerViewOutput!
    
    private let datePicker = UIDatePicker()
    
    /**
     Completion block, that returns date (chosen by user) to the DiaryViewController
     */
    var completionBlock: CompletionBlockDate?

    static func createWith(presenter: DatePickerViewOutput) -> DatePickerViewController {
        let vc = DatePickerViewController()
        vc.presenter = presenter
        return vc
    }
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(view: self) 
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.upgradeGradientBackground()
    }
}
    
// MARK: - Date Picker Presenter Output

extension DatePickerViewController: DatePickerPresenterOutput {
    
    func showExistingDateAlert() {
        let alert = UIAlertController(title: "Такая дата уже существует в дневнике", message: "Выберите другую дату", preferredStyle: .alert) // or "This date already exists in the diary", "Choose another date"
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func returnToDiary() {
        // Call completion block with chosen date
        guard let cb = completionBlock else { return }
        cb(datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Setup and layout of view

extension DatePickerViewController {
    
    func setupView() {
        
        view.setGradientBackground(colorTop: AppColor.whiteShade, colorBottom: AppColor.yellowShade)
        
        // Setup of subviews
        let doneButton = UIButton()
        doneButton.styleActionWith(title: "Готово", color: AppColor.lightBlueShade) // or "Done"
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        
        let cancelButton = UIButton()
        cancelButton.styleActionWith(title: "Отмена", color: AppColor.redShade) // or "Cancel"
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
        datePicker.date = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru")
        
        // Add and layout of subviews
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(doneButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cancelButton)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            
            // X axis
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            doneButton.widthAnchor.constraint(equalToConstant: 120),
            doneButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalTo: doneButton.widthAnchor),
            
            // Y axis
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 20),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor),
            cancelButton.heightAnchor.constraint(equalTo: doneButton.heightAnchor)
        ])
    }
}

// MARK: - Action handlers

extension DatePickerViewController {
    
    /**
     Close date picker view to return to the diary view
     */
    @objc func cancelButtonAction(sender: UIButton!) {
        sender.pressAnimation(){_ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /**
     Pass chosen date to the presenter
     */
    @objc func doneButtonAction(sender: UIButton!) {
        sender.pressAnimation() {_ in
            self.presenter.choseDate(date: self.datePicker.date)
        }
    }
}
