//
//  BottomHeaderView.swift
//  Ufood
//
//  Created by Ольга on 07.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class BottomHeaderView: VerticalGradientView {
    
    private weak var homeController: FoodViewController!
    
    /**
     Used to provide the user with the ability to select the color of food's marker in the diary.
     When user taps to one of markers, this current marker must be deblur, while the rest must be blur.     
     */
    private var allColorMarkers = [ColorMarkerView]()
    
    /**
     Index of the current color marker
     */
    private var currentColorMarker: Int
    
    /**
     Used for different displaying user interface depending on it's add or edit food view
     */
    private let isAddMode: Bool
        
    init(colorMarker: Int, addMode: Bool, homeController: FoodViewController){
        self.currentColorMarker = colorMarker
        self.isAddMode = addMode
        self.homeController = homeController
        super.init(topColor: AppColor.lightBlueShade, bottomColor: AppColor.whiteShade)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
// MARK: - Setup view
    
extension BottomHeaderView {
    
    func setupView() {
        
        // Create main button
        // Title and icon depends on mode is adding or editing
        let mainButton = UIButton()
        let mainButtonIcon = UIImageView()
        let title: String
        if isAddMode {
            title = "Добавить в дневник" // or "Add to diary"
            mainButtonIcon.image = UIImage(named:"addIcon")
        } else {
            title = "Обновить в дневнике" // or "Upgrade in diary"
            mainButtonIcon.image = UIImage(named:"editIcon")
        }
        mainButton.styleActionWith(title: title, color: AppColor.darkBlueShade)
        mainButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        mainButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        mainButton.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
        
        // Create table's title label
        let nutrientsLabel = UILabel()
        nutrientsLabel.styleMediumCenterWith(text: "Пищевая ценность продукта:") // or "Nutritional value of the food"
        
        // Create view panel that contains color markers
        let markersView = createColorMarkersPanel()
        
        // Add and layout of subviews
        self.translatesAutoresizingMaskIntoConstraints = false
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainButton)
        mainButtonIcon.translatesAutoresizingMaskIntoConstraints = false
        mainButton.addSubview(mainButtonIcon)
        nutrientsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nutrientsLabel)
        self.addSubview(markersView)
        NSLayoutConstraint.activate([
            
            // X axis
            markersView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            markersView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 250),
            mainButton.trailingAnchor.constraint(equalTo: mainButtonIcon.trailingAnchor, constant: 17),
            nutrientsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Y axis
            markersView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            markersView.heightAnchor.constraint(equalToConstant: 150),
            mainButton.topAnchor.constraint(equalTo: markersView.bottomAnchor, constant: 5),
            mainButton.heightAnchor.constraint(equalToConstant: 40),
            mainButtonIcon.centerYAnchor.constraint(equalTo: mainButton.centerYAnchor),
            nutrientsLabel.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 10),
            self.bottomAnchor.constraint(equalTo: nutrientsLabel.bottomAnchor, constant: 10)
        ])
    }
    
    /**
     Creates view panel with color markers
     */
    func createColorMarkersPanel() -> UIView {
        let panelView = UIView()
        
        // Create and layout of info label
        let infoLabel = UILabel()
        infoLabel.styleMediumCenterWith(text: "Выберите цветовую метку") // or "Choose color marker"
        
        panelView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        panelView.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: panelView.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: panelView.topAnchor, constant: 10)
        ])
        
        // Create color markers of top row
        // Fix outside markers to panel view edges
        // Index/tag of color marker must correspond to image names in Assets
        var topMarkers = [ColorMarkerView]()
        for i in 0...3 {
            let marker = ColorMarkerView(tag: i)
            panelView.addSubview(marker)
            marker.centerYAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 40).isActive = true
            if i == 0 {
                marker.leadingAnchor.constraint(equalTo: panelView.leadingAnchor, constant: 15).isActive = true
            }
            if i == 3 {
                panelView.trailingAnchor.constraint(equalTo: marker.trailingAnchor, constant: 15).isActive = true
            }
            topMarkers.append(marker)
        }
        
        // Create layout guides like pseudo-views for align of color markers of bottom row
        var guides = [UILayoutGuide]()
        for _ in topMarkers.dropLast() {
            let guide = UILayoutGuide()
            panelView.addLayoutGuide(guide)
            guides.append(guide)
        }
        
        // Setup constraints of guides vertically, with arbitrary values
        let anc = panelView.topAnchor
        for guide in guides {
            guide.topAnchor.constraint(equalTo: anc).isActive = true
            guide.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        // Fix guides leading to previous view
        for (view,guide) in zip(topMarkers.dropLast(), guides) {
            let c = view.trailingAnchor.constraint(equalTo: guide.leadingAnchor)
            c.priority = UILayoutPriority.init(999.0)
            c.isActive = true
        }
        
        // Fix guides trailing to next view
        for (view,guide) in zip(topMarkers.dropFirst(), guides) {
            view.leadingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        }
        
        // Guide widths equal to each other
        let width = guides[0].widthAnchor
        for guide in guides.dropFirst() {
            guide.widthAnchor.constraint(equalTo: width).isActive = true
        }
        
        // Create color markers of bottom row
        // Index/tag must correspond to image names in Assets
        var bottomMarkers = [ColorMarkerView]()
        for i in 4...6 {
            let marker = ColorMarkerView(tag: i)
            panelView.addSubview(marker)
            panelView.bottomAnchor.constraint(equalTo: marker.bottomAnchor, constant: 10).isActive = true
            bottomMarkers.append(marker)
        }
        
        // Fix markers centers to guides centers vertically
        for (view,guide) in zip(bottomMarkers, guides) {
            view.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        }
        
        // Merge all markers in one array, add for each marker tap recognizer
        allColorMarkers = topMarkers + bottomMarkers
        allColorMarkers.forEach { $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))}
        
        //  Set deblur image for current color marker, rest are blur by default
        allColorMarkers[currentColorMarker].deblurImage()
        
        return panelView
    }
}

// MARK: - Actions handler

extension BottomHeaderView {
    
    /**
     Handles tap to color marker.
     If tapped marker isn't current, it becomes current and must get deblurred, previous marker must get blurred.
     New index of current color marker passes to the view controller.
     */
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let colorMarker = sender.view as? ColorMarkerView else { return }
        if colorMarker.tag != currentColorMarker {
            colorMarker.deblurImage()
            allColorMarkers[currentColorMarker].blurImage()
            currentColorMarker = colorMarker.tag
            homeController.colorMarkerAction(newValue: currentColorMarker)
        }
    }
    
    /**
     Reports to the view controller, that user tapped to main button
     */
    @objc func mainButtonAction(_ sender: UIButton) {
        sender.pressAnimation(){_ in
            self.homeController.mainButtonAction()
        }
    }
}
