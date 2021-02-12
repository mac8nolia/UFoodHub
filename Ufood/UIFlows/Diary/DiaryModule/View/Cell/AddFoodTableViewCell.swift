//
//  AddFoodTableViewCell.swift
//  Ufood
//
//  Created by Ольга on 02.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class AddFoodTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = AppColor.whiteShade

        // Setup of background view
        let view = UIView()
        view.backgroundColor = AppColor.lightBlueShade
        view.roundCorners(corners: [.bottomRight,.topRight,.bottomLeft,.topLeft], radius: 7)
        
        // Setup of label
        let label = UILabel()
        label.text = "Добавить продукт" // or "Add food"
        label.textColor = .white
        label.font = AppFont.defaultBoldFont(size: 17)
        
        // Add and layout of subviews
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            
            // X axis
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 7),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Y axis
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
        ])
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
