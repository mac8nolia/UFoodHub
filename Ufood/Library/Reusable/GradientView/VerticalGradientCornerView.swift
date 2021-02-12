//
//  VerticalGradientCornerView.swift
//  Ufood
//
//  Created by Ольга on 11.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

/**
 View with vertical gradient between two colors on background and specified round corners
 */
class VerticalGradientCornerView: VerticalGradientView {

    private var corners: UIRectCorner
    private var radius: CGFloat
    
    init(corners: UIRectCorner, radius: CGFloat, topColor: UIColor, bottomColor: UIColor) {
        self.corners = corners
        self.radius = radius
        super.init(topColor: topColor, bottomColor: bottomColor)
        self.refreshCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.refreshCorners()
    }

    private func refreshCorners() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
