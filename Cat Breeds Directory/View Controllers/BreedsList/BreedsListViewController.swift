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
    @IBOutlet weak var uiCoverWiew: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Properties
    weak var mainCoordinator: MainCoordinator?
    let model = BreedListModel()
    let searchController = UISearchController(searchResultsController: nil)
    var breedsList: [BreedIdAndName] = []
    var breedsListFiltered: [BreedIdAndName] = []
    var selectedBreedID: String = ""
    
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
        searchController.searchBar.placeholder = Constants.searchPlaceHolder
        navigationItem.searchController = searchController
        definesPresentationContext = true //search bar doesn't remains on screen after navigation to another VC
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        loadData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Breeds"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Data loading and processing
    
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


    func updateUI(breedList: [BreedIdAndName]) {
        self.breedsList = breedList
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.uiCoverWiew.removeFromSuperview()
        }
    }
    
    func presentAlert(error: Error) {
        let alert = UIAlertController.init(title: Constants.errorAlertTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.errorAlertButton, style: .default, handler: { _ in
            self.loadData()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}


extension BreedsListViewController: UITableViewDataSource {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return breedsListFiltered.count
        } else {
            return breedsList.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedsList", for: indexPath)

        let breedName: String
        if isFiltering {
            breedName = breedsListFiltered[indexPath.row].name
        } else {
            breedName = breedsList[indexPath.row].name
        }
        cell.textLabel?.text = breedName

        return cell
    }
}


extension BreedsListViewController: UITableViewDelegate {
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            selectedBreedID = breedsListFiltered[indexPath.row].id
        } else {
            selectedBreedID = breedsList[indexPath.row].id
        }
        // MARK: - Navigation
        mainCoordinator?.displayBreedDetails(breedID: selectedBreedID)
    }
}
