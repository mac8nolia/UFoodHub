//
//  HeaderFoodView.swift
//  Ufood
//
//  Created by Ольга on 13.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class HeaderFoodView: UIView {
    
    /**
     Subviews of header view, vertically lined
     */
    private let topView: TopHeaderView
    private let middleView: MiddleHeaderView
    private let bottomView: BottomHeaderView
        
    init(name: String, source: String, quantity: String, colorMarker: Int, addMode: Bool, homeController: FoodViewController) {
        self.topView = TopHeaderView(name: name, source: source)
        self.middleView = MiddleHeaderView(quantity: quantity, homeController: homeController)
        self.bottomView = BottomHeaderView(colorMarker: colorMarker, addMode: addMode, homeController: homeController)
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        // Add and layout of subviews
        self.addSubview(bottomView)
        self.addSubview(middleView)
        self.addSubview(topView)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: middleView.topAnchor, constant: 100),
            
            middleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            middleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            middleView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 100),
            
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    /**
     Delegates to the top subview to change font's size of food name's label
     */
    func changeFontSizeForNameLabel(width: CGFloat) {
        topView.changeFontSizeForNameLabel(width: width)
    }
    
    /**
     Delegates to the middle subview to display new quantity in text field
     */
    func changeQuantityTextField(text: String) {
        middleView.changeQuantityTextField(text: text)
    }
}
