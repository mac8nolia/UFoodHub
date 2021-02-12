//
//  TabBarController.swift
//  Ufood
//
//  Created by Ольга on 03.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var presenter: TabBarControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

//MARK: - Tab Bar Controller Delegate

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // If chosen tab is statistics tab - open action sheet for choose period of statistics
        if viewController.tabBarItem.tag == Tab.statistics.rawValue {
            
            let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            for i in 0...(presenter.periodsNumber() - 1) {
                let action: UIAlertAction = UIAlertAction(title: presenter.periodName(index: i), style: .default) { action -> Void in
                    self.actionHandler(index: i)
                }
                actionSheetController.addAction(action)
            }
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Отмена", style: .cancel) { action -> Void in } // or "Cancel"
            actionSheetController.addAction(cancelAction)
            
            present(actionSheetController, animated: true)
            return false
        }
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        // Move back to the root controller (diary flow)
        if let vc = viewController as? UINavigationController {
            vc.popViewController(animated: false);
        }
    }
}

//MARK: - Actions handler

extension TabBarController {
    
    /**
     Calls when user chose statistics period in the action sheet.
     Passes to presenter this period.
     */
    func actionHandler(index: Int) {
        presenter.periodChosen(index: index)
    }
}


//MARK: - Tab Bar Presenter Output

extension TabBarController: TabBarPresenterOutput {
    
    func showStatisticsView() {
        self.selectedIndex = Tab.statistics.rawValue
        
        // Move back to the root controller (statistics flow)
        if let vc = self.viewControllers?[Tab.statistics.rawValue] as? UINavigationController {
            vc.popViewController(animated: false);
        }
    }
    
    func showPeriodAlert() {
        let alert = UIAlertController(title: "В выбранном периоде отсутствуют продукты", message: "Выберите другой период", preferredStyle: .alert) // or "There are no foods in the selected period", "Choose another period"
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true)
    }
}


