//
//  DiaryTableViewCell.swift
//  Ufood
//
//  Created by Ольга on 03.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    private let foodNameLabel = UILabel()
    
    private let foodQuantityLabel = UILabel()
    
    private let colorMarkerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = AppColor.whiteShade
        
        // Setup of labels
        foodNameLabel.textAlignment = .left
        foodNameLabel.font = AppFont.defaultRegularFont(size: 16)
        foodNameLabel.numberOfLines = 2

        foodQuantityLabel.font = AppFont.defaultBoldFont(size: 17)
        foodQuantityLabel.textAlignment = .right
        foodQuantityLabel.adjustsFontSizeToFitWidth = true
        foodQuantityLabel.minimumScaleFactor = 0.5
        
        // Create cell's disclosure
        let disclosure = UIImageView()
        disclosure.image = UIImage(named:"disclosure")
        
        // Create background view with shadow
        let backView = UIView()
        backView.backgroundColor = AppColor.whiteShade
        backView.roundCorners(corners: [.bottomRight,.topRight], radius: 7)
        backView.layer.applyDesignShadow(color: .black, alpha: 0.24, x: 0, y: 0, blur: 6, spread: 0)

        // Add and layout of backView subviews
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(foodNameLabel)
        foodQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(foodQuantityLabel)
        disclosure.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(disclosure)
        NSLayoutConstraint.activate([
            
            // X axis
            foodNameLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 11),
            foodQuantityLabel.leadingAnchor.constraint(equalTo: foodNameLabel.trailingAnchor, constant: 15),
            foodQuantityLabel.widthAnchor.constraint(equalToConstant: 60),
            disclosure.leadingAnchor.constraint(equalTo: foodQuantityLabel.trailingAnchor, constant: 10),
            disclosure.widthAnchor.constraint(equalToConstant: 10),
            backView.trailingAnchor.constraint(equalTo: disclosure.trailingAnchor, constant: 8),
            
            // Y axis
            foodNameLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            foodQuantityLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            disclosure.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
        ])
        
        // Setup color marker view
        colorMarkerView.roundCorners(corners: [.bottomLeft,.topLeft], radius: 7)
        
        // Add and layout of cell's subviews
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        colorMarkerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(colorMarkerView)
        NSLayoutConstraint.activate([
            
            // X axis
            colorMarkerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            colorMarkerView.widthAnchor.constraint(equalToConstant: 13),
            backView.leadingAnchor.constraint(equalTo: colorMarkerView.trailingAnchor),
            contentView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 7),
            
            // Y axis
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            contentView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 3),
            colorMarkerView.topAnchor.constraint(equalTo: backView.topAnchor),
            colorMarkerView.bottomAnchor.constraint(equalTo: backView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Diary presenter output cell delegate

extension DiaryTableViewCell: DiaryPresenterOutputCell {
    
    func show(name: String, quantity: String, colorMarker: Int) {
        foodNameLabel.text = name
        foodQuantityLabel.text = quantity + " г" // or " g"
        colorMarkerView.backgroundColor = AppColor.markerColors[colorMarker]
    }
}
