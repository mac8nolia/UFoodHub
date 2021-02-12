//
//  UITableViewExtensions.swift
//  Ufood
//
//  Created by Ольга on 12.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
     Sets view to tableHeaderView
     */
    func setTableHeaderView(headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.tableHeaderView = headerView
        
        // Must setup autolayout after set tableHeaderView
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    /**
     Updates layout of tableHeaderView, when it's frame changed
     */
    func updateHeaderViewFrame() {
        guard let headerView = self.tableHeaderView else { return }
        
        // Update the size of the header based on it's internal content
        headerView.layoutIfNeeded()
        
        // Trigger the table view to know that header should be updated
        let header = self.tableHeaderView
        self.tableHeaderView = header
    }
}
