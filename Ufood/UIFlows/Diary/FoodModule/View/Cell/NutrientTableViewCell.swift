//
//  NutrientTableViewCell.swift
//  Ufood
//
//  Created by Ольга on 07.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class NutrientTableViewCell: UITableViewCell {

    /**
     Labels with name, total amount at food and daily value ratio of the nutrient
     */
    private let nameLabel = UILabel()
    private let amountLabel = UILabel()
    private let dvRatioLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewCell() {
        backgroundColor = AppColor.whiteShade
        
        // Setup of labels
        nameLabel.styleCellName()
        amountLabel.styleCellValue()
        dvRatioLabel.styleCellValue()
        
        // Add and layout of labels
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountLabel)
        dvRatioLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dvRatioLabel)
        NSLayoutConstraint.activate([
            
            // X axis
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            amountLabel.centerXAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 50),
            amountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            dvRatioLabel.centerXAnchor.constraint(equalTo: amountLabel.centerXAnchor, constant: 80),
            dvRatioLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 48),
            contentView.trailingAnchor.constraint(equalTo: dvRatioLabel.centerXAnchor, constant: 40),
            
            // Y axis
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            contentView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11),
            amountLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            dvRatioLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
}

// MARK: - Food presenter output cell delegate

extension NutrientTableViewCell: FoodPresenterOutputCell {
    
    func showNutrient(name: String, amount: String, dailyValueRatio: String) {
        nameLabel.text = name
        amountLabel.text = amount
        dvRatioLabel.text = dailyValueRatio
    }
}

