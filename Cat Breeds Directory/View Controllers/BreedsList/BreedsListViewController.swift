//
//  BreedsListViewController.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 03.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class BreedsListViewController: UIViewController, Storyboarded, UISearchResultsUpdating {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    ///Cover the UI untill GET request will be comleted.
    @IBOutlet weak var uiCoverWiew: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Properties
    weak var mainCoordinator: MainCoordinator?
    let model = BreedListModel()
    let searchController = UISearchController(searchResultsController: nil)
    var breedsList: [BreedIdAndName] = []
    var breedsListFiltered: [BreedIdAndName] = []
    
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK: - ViewControllerLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Strings.searchPlaceHolder
        navigationItem.searchController = searchController
        definesPresentationContext = true //search bar doesn't remains on screen after navigation to another VC
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        loadData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Breeds"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Data loading and processing
    ///Update UI if succes or present an Alert in case of failure.
    func loadData() {
        model.getBreedsList { [weak self] result in
            switch result {
            case .success(let list):
                self?.updateUI(breedList: list)
            case .failure(let error):
                self?.presentAlert(error: error)
            }
        }
    }

    ///Update table view with received data.
    func updateUI(breedList: [BreedIdAndName]) {
        self.breedsList = breedList
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.uiCoverWiew.removeFromSuperview()
        }
    }
    ///Present error alert with `Reload` button
    ///
    ///Present alert with localized error description and button that run data loading again.
    func presentAlert(error: Error) {
        let alert = UIAlertController.init(title: Strings.errorAlertTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.errorAlertButton, style: .default, handler: { _ in
            self.loadData()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
