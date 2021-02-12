//
//  StatisticsTableViewCell.swift
//  Ufood
//
//  Created by Ольга on 22.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    /**
     Labels with name and average daily value ratio of the nutrient
     */
    private let nameLabel = UILabel()
    private let dvRatioLabel = UILabel()
    
    /**
     Bars for visual presence of nutrient's daily value ratio
     */
    private let leftBar = UIView()
    private let rightBar = UIView()
    
    /**
     Constraint, that determines the anchor between the widths of left and right bars
     */
    private var procentConstraint: NSLayoutConstraint!
    
    /**
     Multiplier, that determines the ratio between the widths of left and right bars and used by procentConstraint.
     By default equal to 1.
     */
    //
    private var multiplier: CGFloat = 1.0
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupViewCell() {
        backgroundColor = AppColor.whiteShade
        
        // Setup of labels and icons
        nameLabel.styleCellName()
        dvRatioLabel.styleCellValue()
        let disclosureIcon = UIImageView(image: UIImage(named: "disclosure"))
        let infoIcon = UIImageView(image: UIImage(named: "infoIcon"))
        leftBar.roundCorners(corners: [.topLeft,.bottomLeft], radius: 7)
        rightBar.roundCorners(corners: [.topRight,.bottomRight], radius: 7)
        
        // Add and layout of subviews
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        dvRatioLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dvRatioLabel)
        disclosureIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(disclosureIcon)
        infoIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoIcon)
        leftBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(leftBar)
        rightBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rightBar)
        NSLayoutConstraint.activate([
            
            // X axis
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            infoIcon.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15),
            infoIcon.widthAnchor.constraint(equalToConstant: 22),
            disclosureIcon.leadingAnchor.constraint(equalTo: infoIcon.trailingAnchor, constant: 15),
            disclosureIcon.widthAnchor.constraint(equalToConstant: 10),
            contentView.trailingAnchor.constraint(equalTo: disclosureIcon.trailingAnchor, constant: 15),
            leftBar.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            rightBar.leadingAnchor.constraint(equalTo: leftBar.trailingAnchor),
            dvRatioLabel.leadingAnchor.constraint(equalTo: rightBar.trailingAnchor, constant: 10),
            dvRatioLabel.widthAnchor.constraint(equalToConstant: 90),
            dvRatioLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            // Y axis
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            leftBar.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            leftBar.heightAnchor.constraint(equalToConstant: 25),
            rightBar.topAnchor.constraint(equalTo: leftBar.topAnchor),
            rightBar.bottomAnchor.constraint(equalTo: leftBar.bottomAnchor),
            dvRatioLabel.centerYAnchor.constraint(equalTo: leftBar.centerYAnchor),
            infoIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let c = contentView.bottomAnchor.constraint(equalTo: leftBar.bottomAnchor, constant: 15)
        c.priority = UILayoutPriority.defaultLow
        c.isActive = true
        
        // Set procentConstraint
        procentConstraint = leftBar.widthAnchor.constraint(equalTo: rightBar.widthAnchor, multiplier: multiplier)
    }
}

// MARK: - Statistics Presenter Output Cell

extension StatisticsTableViewCell: StatisticsPresenterOutputCell {
    
    func showNutrient(name: String, dailyValueRatio: Int) {
        nameLabel.text = name
        dvRatioLabel.text = String(dailyValueRatio) + " %РСП" // or "%DV"
        
        // Update multiplier and reactivate procentConstraint
        multiplier = calculateMultiplier(dailyValueRatio: dailyValueRatio)
        procentConstraint = procentConstraint.setMultiplier(multiplier: multiplier)
        
        // Setup colors of bars depending on dailyValueRatio
        switch dailyValueRatio {
        case 0:
            leftBar.backgroundColor = AppColor.lightGrayShade
            rightBar.backgroundColor = AppColor.lightGrayShade
        case 1..<100:
            leftBar.backgroundColor = AppColor.lightBlueShade
            rightBar.backgroundColor = AppColor.lightGrayShade
        case 100:
            leftBar.backgroundColor = AppColor.lightBlueShade
            rightBar.backgroundColor = AppColor.lightBlueShade
        default:
            leftBar.backgroundColor = AppColor.lightBlueShade
            rightBar.backgroundColor = AppColor.redShade
        }

//        leftBar.backgroundColor = AppColor.lightBlueShade
//        if dailyValueRatio > 100 {
//            rightBar.backgroundColor = AppColor.redShade
//        } else {
//            rightBar.backgroundColor = AppColor.lightGrayShade
//            if dailyValueRatio == 0 {
//                leftBar.backgroundColor = AppColor.lightGrayShade
//            }
//        }
    }
}

// MARK: - Helped functions

extension StatisticsTableViewCell {
    
    func calculateMultiplier(dailyValueRatio: Int) -> CGFloat {
        
        // Round average daily value for best visual presence
        var roundValue: CGFloat
        switch dailyValueRatio {
        case 0..<10:
            roundValue = 10
        case 91..<100:
            roundValue = 90
        case 101..<110:
            roundValue = 110
        case 1001...Int.max:
            roundValue = 1000
        default:
            roundValue = CGFloat(dailyValueRatio)
        }
        
        // Calculate multiplier. It must be greater than 1, if average daily value ratio greater than 100 procents. Otherwise - equal or less than 1.
        var multiplier: CGFloat
        if roundValue == 100.0 {
            multiplier = 1
        } else if roundValue < 100 {
            multiplier = roundValue / (100.0 - roundValue)
        } else {
            multiplier = 100.0 / (roundValue - 100.0)
        }
        return multiplier
    }
}
