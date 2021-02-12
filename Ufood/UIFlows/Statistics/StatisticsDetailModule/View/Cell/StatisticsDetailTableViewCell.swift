//
//  StatisticsDetailTableViewCell.swift
//  Ufood
//
//  Created by Ольга on 24.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class StatisticsDetailTableViewCell: UITableViewCell {
    
    /**
     Label with name of food
     */
    let nameLabel = UILabel()
    
    /**
     Label with amount of nutrient in the food
     */
    let amountLabel = UILabel()
        
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
        
        // Add and layout of labels
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            
            // X axis
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            amountLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            amountLabel.widthAnchor.constraint(equalToConstant: 100),
            contentView.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 15),
            
            // Y axis
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            amountLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
}

// MARK: - Statistics Detail Presenter Output Cell

extension StatisticsDetailTableViewCell: StatisticsDetailPresenterOutputCell {
    
    func showFood(name: String, amount: String) {
        nameLabel.text = name
        amountLabel.text = amount
    }
}
