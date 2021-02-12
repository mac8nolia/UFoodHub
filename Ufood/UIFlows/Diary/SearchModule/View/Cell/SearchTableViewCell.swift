//
//  SearchTableViewCell.swift
//  Ufood
//
//  Created by Ольга on 06.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = AppColor.whiteShade
        label.styleCellName()

        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 7),
            contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
        ])
    }
                
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
