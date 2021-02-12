//
//  TabBarConfigurator.swift
//  Ufood
//
//  Created by Ольга on 21.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

/**
 Tabs with tags
 */
enum Tab: Int {
    case diary = 0
    case statistics
}

class TabBarConfigurator {
    
    /**
     Create main tab bar controller, when application launched
     */
    static func configureViewController() -> TabBarController {
        
        // Create tab for diary flow
        let diaryViewController = DiaryViewController()
        let diaryPresenter = DiaryPresenter(view: diaryViewController)
        diaryViewController.presenter = diaryPresenter
        
        let navigationDiaryController = UINavigationController(rootViewController: diaryViewController)
        let diaryIcon = UITabBarItem(title: "Дневник", image: UIImage(named: "diaryTabIcon"), selectedImage: UIImage(named: "diaryTabIconSelect")) // or "Diary"
        navigationDiaryController.tabBarItem = diaryIcon
        
        navigationDiaryController.tabBarItem.tag = Tab.diary.rawValue
        
        // Create tab for statistics flow
        let statisticsViewController = StatisticsViewController()
        let statisticsPresenter = StatisticsPresenter(view: statisticsViewController)
        statisticsViewController.presenter = statisticsPresenter
        
        let navigationStatisticsController = UINavigationController(rootViewController: statisticsViewController)
        let statisticsIcon = UITabBarItem(title: "Статистика", image: UIImage(named: "statTabIcon"), selectedImage: UIImage(named: "statTabIconSelect")) // or "Statistics"
        navigationStatisticsController.tabBarItem = statisticsIcon
        
        navigationStatisticsController.tabBarItem.tag = Tab.statistics.rawValue
        
        // Create tab controller
        let tabBarController = TabBarController()
        let tabBarPresenter = TabBarPresenter(view: tabBarController)
        tabBarController.presenter = tabBarPresenter
        
        tabBarController.viewControllers = [navigationDiaryController,navigationStatisticsController]
        
        // Add created presenters to tab bar controller's presenter for direct access
        tabBarPresenter.childPresenters = [diaryPresenter,statisticsPresenter]
        
        return tabBarController
    }
}
