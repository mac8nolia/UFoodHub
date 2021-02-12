//
//  NutrientsGroupHeaderView.swift
//  Ufood
//
//  Created by Ольга on 13.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class NutrientsGroupHeaderView: UIView {

    private let nameLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = AppColor.lightGrayShade
        
        // Create and setup of labels
        nameLabel.styleCellName()
        let amountLabel = UILabel()
        amountLabel.styleRegularCenterWith(text: "Кол-во") // or "Quantity"
        let dailyValueLabel = UILabel()
        dailyValueLabel.styleRegularCenterWith(text: "%РСП") // or "%DV"

        // Add and layout of labels
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(amountLabel)
        dailyValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dailyValueLabel)
        NSLayoutConstraint.activate([
            
            // X axis
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            amountLabel.centerXAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 40),
            amountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 60),
            dailyValueLabel.centerXAnchor.constraint(equalTo: amountLabel.centerXAnchor, constant: 80),
            dailyValueLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 60),
            self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: dailyValueLabel.centerXAnchor, constant: 40),
            
            // Y axis
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            self.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11),
            amountLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            dailyValueLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
}

// MARK: - Food Presenter Output Header

extension NutrientsGroupHeaderView: FoodPresenterOutputHeader {
    
    func showNutrientsGroup(name: String) {
        nameLabel.text = name
    }
}
