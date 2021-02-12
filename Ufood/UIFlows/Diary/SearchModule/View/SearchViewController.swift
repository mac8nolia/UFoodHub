//
//  SearchViewController.swift
//  Ufood
//
//  Created by Ольга on 04.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    private var presenter: SearchViewOutput!
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    static func createWith(presenter: SearchViewOutput) -> SearchViewController {
        let vc = SearchViewController()
        vc.presenter = presenter
        return vc
    }

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.set(view: self)
        
        tableView.backgroundColor = AppColor.whiteShade
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.keyboardDismissMode = .onDrag
        
        setupSearchController()
        extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(backgroundColor: AppColor.darkBlueShade, tintColor: AppColor.yellowShade, title: "Поиск", translucent: false, hideBorderLine: false) // or "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.isActive = true
    }
}

// MARK: - Setup search controller

extension SearchViewController {
    
    func setupSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.placeholder = "Поиск" // or "Search"
        searchController.searchBar.setTextField(backgroundColor: AppColor.whiteShade)
        
        // Set color and title for cancel button
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor : AppColor.yellowShade], for: .normal)
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText") // or "Cancel"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - Table View Data Source

extension SearchViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.resultsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        cell.label.text = presenter.resultName(index: indexPath.row)
        return cell
    }
}
    
// MARK: - Table View Delegate

extension SearchViewController {
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showResultDetails(index: indexPath.row)
    }
}

// MARK: - Search Presenter Output

extension SearchViewController: SearchPresenterOutput {
    
    func redraw() {
        tableView.reloadData()
    }
    
    func showFoodViewWith(nextPresenter: FoodPresenter) {
        let vc = FoodViewController.createWith(presenter: nextPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Search Results Updating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        presenter.change(searchText: text)
    }
}

// MARK: - Search Controller Delegate

extension SearchViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
}
