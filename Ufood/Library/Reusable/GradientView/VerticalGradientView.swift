//
//  VerticalGradientView.swift
//  Ufood
//
//  Created by Ольга on 11.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

/**
 View with vertical gradient between two colors on background
 */
class VerticalGradientView: UIView {
    
    private var topColor: UIColor
    private var bottomColor: UIColor
    
    init(topColor: UIColor, bottomColor: UIColor) {
        self.topColor = topColor
        self.bottomColor = bottomColor
        super.init(frame: CGRect.zero)
        setGradient()
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setGradient()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setGradient() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
        (layer as! CAGradientLayer).startPoint = CGPoint(x: 0.5, y: 0)
        (layer as! CAGradientLayer).endPoint = CGPoint(x: 0.5, y: 1)
    }
}
