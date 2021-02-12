//
//  StatisticsViewController.swift
//  Ufood
//
//  Created by Ольга on 04.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class StatisticsViewController: UITableViewController {
    
    var presenter: StatisticsViewOutput!
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.whiteShade
        tableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: "StatisticsCell")
    }
}

// MARK: - Table View Data Source

extension StatisticsViewController {
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.nutrientsGroupsCount()
    }
        
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.nameOfNutrientsGroup(index: section)
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.nutrientsCountInGroup(index: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsTableViewCell
        presenter.configure(cell: cell, indexPath: indexPath)
        return cell
    }
}

// MARK: - Table View Delegate

extension StatisticsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showDetailNutrient(indexPath: indexPath)
    }
}

// MARK: - Statistics Presenter Output View

extension StatisticsViewController: StatisticsPresenterOutputView {
    
    func redraw() {
        tableView.reloadData()
    }
    
    func set(title: String) {
        configureNavigationBar(backgroundColor: AppColor.whiteShade, tintColor: AppColor.darkBlueShade, title: title, translucent: false, hideBorderLine: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.darkBlueShade]
    }
    
    func showDetail(presenter: StatisticsDetailPresenter) {
        let vc = StatisticsDetailViewController.createWith(presenter: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}
