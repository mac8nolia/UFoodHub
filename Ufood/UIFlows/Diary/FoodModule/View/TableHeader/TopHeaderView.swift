//
//  TopHeaderView.swift
//  Ufood
//
//  Created by Ольга on 07.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class TopHeaderView: VerticalGradientCornerView {
    
    private let nameLabel = UILabel()
    
    private let sourceLabel = UILabel()
        
    init(name: String, source: String){
        nameLabel.text = name
        sourceLabel.text = "Источник: " + source // or "Source: "
        super.init(corners: [.bottomLeft,.bottomRight], radius: 90, topColor: AppColor.whiteShade, bottomColor: AppColor.yellowShade)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        // Setup of labels
        nameLabel.textAlignment = .center
        nameLabel.font = AppFont.defaultMediumFont(size: 20)
        nameLabel.numberOfLines = 0
        
        sourceLabel.font = AppFont.defaultRegularFont(size: 17)
        sourceLabel.textAlignment = .center
        
        // Add and layout of subviews
        self.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sourceLabel)
        NSLayoutConstraint.activate([
            
            // X axis
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            sourceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Y axis
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            sourceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            self.bottomAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 5),
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
        
        let c = self.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 40)
        c.priority = UILayoutPriority.init(999.0)
        c.isActive = true
    }
    
    func changeFontSizeForNameLabel(width: CGFloat) {
        guard let _ = nameLabel.text, let currentFont = nameLabel.font else { return }
        // Create array with different variations of pairs of font's size and number of lines at label
        let sizeArray: [(fontSize: CGFloat, numberOfLines: Int)] = [
                        (28, 1),
                        (26, 2),
                        (24, 3),
                        (22, 4),
                        (20, 5)]
        // Pick appropriate font's size for specified width of label
        let chosenSize = nameLabel.pickFontSizeFrom(array: sizeArray, forWidth: width, andFont: currentFont)
        // Set font with new size to name's label
        nameLabel.font = AppFont.defaultMediumFont(size: chosenSize)
    }
}
