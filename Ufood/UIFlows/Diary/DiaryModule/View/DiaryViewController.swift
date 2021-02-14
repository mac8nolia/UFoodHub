//
//  DiaryViewController.swift
//  Ufood
//
//  Created by Ольга on 01.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class DiaryViewController: UITableViewController {
    
    var presenter: DiaryViewOutput!
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = AppColor.darkBlueShade
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil) // or "Back"
        let addDayBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDayAction))
        self.navigationItem.rightBarButtonItem  = addDayBarButtonItem
                
        tableView.rowHeight = 54
        tableView.sectionHeaderHeight = 37
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: "DiaryCell")
        tableView.register(AddFoodTableViewCell.self, forCellReuseIdentifier: "AddFoodCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigationBar(backgroundColor: AppColor.darkBlueShade, tintColor: AppColor.yellowShade, title: "Дневник питания", translucent: false, hideBorderLine: false) // or "Food diary"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.yellowShade]
        
        presenter.upgradeData()
    }
}

// MARK: - Table View Data Source

extension DiaryViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.daysCount()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = DayHeaderView(homeController: self)
        presenter.configure(sectionHeader: sectionHeader, sectionIndex: section)
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Consider AddFood cell
        return presenter.foodsCountInDay(index: section) + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numberOfRowsInSection = presenter.foodsCountInDay(index: indexPath.section)
        if indexPath.row == numberOfRowsInSection {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddFoodCell", for: indexPath) as! AddFoodTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryTableViewCell
            presenter.configure(cell: cell, indexPath: indexPath) 
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let numberOfRowsInSection = presenter.foodsCountInDay(index: indexPath.section)
        
        // AddFood cell shouldn't be editable
        if indexPath.row == numberOfRowsInSection {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteFood(indexPath: indexPath)
        }
    }
}

// MARK: - Table View Delegate

extension DiaryViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Selected AddFood cell entails adding new food
        // Selected other cells entails editing existing food
        let numberOfRowsInSection = presenter.foodsCountInDay(index: indexPath.section)
        if indexPath.row == numberOfRowsInSection {
            presenter.addListedFood(index: indexPath.section)
        } else {
            presenter.editListedFood(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить" //or "Delete"
    }
}

// MARK: - Diary Presenter Output View

extension DiaryViewController: DiaryPresenterOutputView {
    
    func redraw() {
        tableView.reloadData()
    }
    
    func showDatePickerWith(presenter: DatePickerPresenter) {
        let vc = DatePickerViewController.createWith(presenter: presenter)
        // Create completion block for return of chosen date from date picker
        vc.completionBlock = {[weak self] dataReturned in
            self?.datePickerChosen(date: dataReturned)
        }
        present(vc, animated: true, completion: nil)
    }
    
    func showSearchWith(nextPresenter: SearchPresenter) {
        let vc = SearchViewController.createWith(presenter: nextPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }

    func showListedFoodWith(nextPresenter: FoodPresenter) {
        let vc = FoodViewController.createWith(presenter: nextPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Action handlers

extension DiaryViewController {
    
    @objc func addDayAction() {
        presenter.addCurrentDay()
    }
    
    func datePickerChosen(date: Date) {
        presenter.createDay(date: date)
    }
    
    func deleteDayAction(index: Int) {
        presenter.deleteDay(index: index)
    }
}

