//
//  ColorMarker.swift
//  Ufood
//
//  Created by Ольга on 12.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class ColorMarkerView: UIView {
    
    /**
     Container for image, which can be blur or deblur
     */
    private var imageView = UIImageView()
    
    /**
     Returns name of deblur image.
     Tags of ColorMarkerView must correspond to image names in Assets.
     */
    private var deblurImageName: String {
        return "colorMarker" + String(tag) + ".png"
    }
    
    /**
     Returns name of blur image.
     Tags of ColorMarkerView must correspond to image names in Assets.
     */
    private var blurImageName: String {
        return "colorMarker" + String(tag) + "blur.png"
    }
    
    init(tag: Int){
        super.init(frame: CGRect.zero)
        self.tag = tag
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Set blur image in image view
     */
    func blurImage() {
        imageView.image = UIImage(named: blurImageName)
    }
    
    /**
     Set deblur image in image view
     */
    func deblurImage() {
        imageView.image = UIImage(named: deblurImageName)
    }
        
    func setupView() {
        self.isUserInteractionEnabled = true
        
        // Add and layout of image view
        self.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 45),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        let c = self.widthAnchor.constraint(equalToConstant: 45)
        c.priority = UILayoutPriority.init(999.0)
        c.isActive = true
        
        // Set blur image in image view by default
        blurImage()
    }
}
