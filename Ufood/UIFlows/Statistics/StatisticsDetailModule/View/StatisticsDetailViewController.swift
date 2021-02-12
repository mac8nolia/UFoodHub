//
//  StatisticsDetailViewController.swift
//  Ufood
//
//  Created by Ольга on 23.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class StatisticsDetailViewController: UITableViewController {
    
    private var presenter: StatisticsDetailViewOutput!
            
    static func createWith(presenter: StatisticsDetailPresenter) -> StatisticsDetailViewController {
        let vc = StatisticsDetailViewController()
        vc.presenter = presenter
        return vc
    }

    // MARK: - View controller life cycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.set(view: self)
        
        self.view.backgroundColor = AppColor.whiteShade
        tableView.register(StatisticsDetailTableViewCell.self, forCellReuseIdentifier: "StatisticsDetailCell")
        
        // Set and layout header view within table view
        let headerView = createHeaderView()
        self.tableView.setTableHeaderView(headerView: headerView)
        self.tableView.updateHeaderViewFrame()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(backgroundColor: AppColor.whiteShade, tintColor: AppColor.darkBlueShade, title: "", translucent: false, hideBorderLine: true)
        DispatchQueue.main.async {
            self.tableView.updateHeaderViewFrame()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.tableView.updateHeaderViewFrame()
        }
    }
}

// MARK: - Setup of view

extension StatisticsDetailViewController {
        
    func createHeaderView() -> UIView {
        let headerView = VerticalGradientView(topColor: AppColor.whiteShade, bottomColor: AppColor.yellowShade)
        
        // Create label with nutrient's name
        let nameLabel = UILabel()
        nameLabel.styleMediumCenterWith(text: presenter.getNutrientName())
        nameLabel.numberOfLines = 0
        
        // Create label with total amount of nutrient
        let totalAmountLabel = UILabel()
        totalAmountLabel.styleMediumCenterWith(text: presenter.getNutrientTotalAmount())
        
        // Create helped info labels
        let amountLabel = UILabel()
        amountLabel.styleRegularCenterWith(text: "Общее количество:") // or "Total amount:"
        let contentLabel = UILabel()
        contentLabel.styleRegularCenterWith(text: "Содержание в продуктах:") // or "Content in foods:"
        
        // Add and layout of labels
        headerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(nameLabel)
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(totalAmountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(amountLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            
            // X axis
            nameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            amountLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            totalAmountLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            contentLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            
            // Y axis
            nameLabel.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 5),
            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            totalAmountLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 5),
            contentLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 15),
            headerView.bottomAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 5)
        ])
        
        let c = headerView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15)
        c.priority = UILayoutPriority.init(999.0)
        c.isActive = true
        
        return headerView
    }
}

// MARK: - Table View Data Source

extension StatisticsDetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.foodsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsDetailCell", for: indexPath) as! StatisticsDetailTableViewCell 
        presenter.configure(cell: cell, indexPath: indexPath)
        return cell
    }
}

// MARK: - Statistics Detail Presenter Output View

extension StatisticsDetailViewController: StatisticsDetailPresenterOutputView { }

