//
//  FoodViewController.swift
//  Ufood
//
//  Created by Ольга on 16.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class FoodViewController: UITableViewController {
    
    private var presenter: FoodPresenter!
    
    /**
     Contains current screen's width.
     When it cnahges - changes font's size of food name's label.
     */
    private var screenWidth: CGFloat!
    
    /**
     Header of table view, represent food's detail information
     */
    private var headerView: HeaderFoodView!
    
    static func createWith(presenter: FoodPresenter) -> FoodViewController {
        let vc = FoodViewController()
        vc.presenter = presenter
        return vc
    }

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.set(view: self)
        
        // Setup of view
        self.view.backgroundColor = AppColor.whiteShade
        tableView.register(NutrientTableViewCell.self, forCellReuseIdentifier: "NutrientCell")
        
        // Call presenter for next view setup
        presenter.loadViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(backgroundColor: AppColor.whiteShade, tintColor: AppColor.darkBlueShade, title: "", translucent: false, hideBorderLine: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Check if screen width changed - change font of food's name label and update layout of table view
        if self.view.bounds.width != screenWidth {
            screenWidth = self.view.bounds.width
            headerView.changeFontSizeForNameLabel(width: screenWidth - 60.0)
            self.tableView.updateHeaderViewFrame()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}

// MARK: - Table View Data Source

extension FoodViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.nutrientsGroupsCount()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = NutrientsGroupHeaderView()
        presenter.configure(sectionHeader: sectionHeader, sectionIndex: section)
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.nutrientsCountInGroup(index: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutrientCell", for: indexPath) as! NutrientTableViewCell
        presenter.configure(cell: cell, indexPath: indexPath)
        return cell
    }
}
    
// MARK: - Food Presenter Output View

extension FoodViewController: FoodPresenterOutputView { 
    
    func showFoodDetails(name: String, source: String, quantity: String, colorMarker: Int, addMode: Bool) {
        // Create header of table view for represent details of the food
        headerView = HeaderFoodView(name: name, source: source, quantity: quantity, colorMarker: colorMarker, addMode: addMode, homeController: self)
        // Set and layout header view within table view
        self.tableView.setTableHeaderView(headerView: headerView)
        self.tableView.updateHeaderViewFrame()
    }
    
    func redraw() {
        tableView.reloadData()
    }
    
    func showQuantityHelper(presenter: FoodWeightPresenter) {
        let vc = FoodWeightViewController.createWith(presenter: presenter)
        // Create completion block for return of chosen weight from food weight view
        vc.completionBlock = {[weak self] dataReturned in
            self?.foodWeightReturned(value: dataReturned)
        }
        present(vc, animated: true, completion: nil)
    }
    
    func backToDiary() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Action handlers

extension FoodViewController {
    
    func mainButtonAction() {
        presenter.doneAction()
    }
    
    func colorMarkerAction(newValue: Int) {
        presenter.colorMarkerChanged(value: newValue)
    }
    
    func foodWeightReturned(value: Int) {
        headerView.changeQuantityTextField(text: String(value))
        presenter.quantityChanged(value: value)
    }
    
    func quantityTextFieldDoneAction(text: String) {
        let quantity = Int(text) ?? 0
        presenter.quantityChanged(value: quantity)
    }
    
    func quantityHelperButtonAction() {
        presenter.quantityHelperAction()
    }
}

