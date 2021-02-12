//
//  DayHeaderView.swift
//  Ufood
//
//  Created by Ольга on 20.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class DayHeaderView: UIView {
    
    private let dateLabel = UILabel()
    
    /**
     Button for deleting day
     */
    private let deleteButton = UIButton()
    
    private weak var homeController: DiaryViewController!
    
    init(homeController: DiaryViewController) {
        self.homeController = homeController
        super.init(frame: CGRect.zero)
        setupSectionHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSectionHeaderView() {
        self.backgroundColor = AppColor.darkBlueShade
        
        // Setup of subviews
        dateLabel.font = AppFont.defaultRegularFont(size: 17)
        dateLabel.textAlignment = .center
        dateLabel.textColor = AppColor.yellowShade
        
        deleteButton.setImage(UIImage(named: "trashCan"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
        // Create bottom border
        let borderView = UIView()
        borderView.backgroundColor = AppColor.whiteShade
        
        // Add and layout of subviews
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateLabel)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deleteButton)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        NSLayoutConstraint.activate([
            
            // X axis
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 40),
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            // Y axis
            self.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor, constant: 1),
            deleteButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
}

// MARK: - Diary Presenter Output Header

extension DayHeaderView: DiaryPresenterOutputHeader {
    
    func showDay(date: String, tag: Int) {
        self.dateLabel.text = date
        self.deleteButton.tag = tag
    }
}

// MARK: - Action handlers

extension DayHeaderView {
    
    @objc func deleteButtonAction(sender: UIButton!) {
        // Show alert to user to confirm deleting the day
        let alert = UIAlertController(title: "Вы действительно хотите удалить день из дневника?", message: "День удалится вместе с продуктами", preferredStyle: .alert) // or "Do you really want to delete the day from diary?,"The day will be deleted along with foods"
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.homeController.deleteDayAction(index: self.deleteButton.tag)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        } // or "Cancel"
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        homeController.present(alert, animated: true, completion: nil)
    }
}



