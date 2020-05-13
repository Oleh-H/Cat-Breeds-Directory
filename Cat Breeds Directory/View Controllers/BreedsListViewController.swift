//
//  BreedsListViewController.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 03.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class BreedsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var uiCoverWiew: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Properties
    
    let networkManager = NetworkManager()
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
        searchController.searchBar.placeholder = "Search breeds"
        navigationItem.searchController = searchController
        definesPresentationContext = true //search bar doesn't remains on screen after navigation to another VC
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        networkManager.getBreedsList(completion: { [weak self] breeds in
            self?.breedsList = breeds
//            print(breeds)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.uiCoverWiew.removeFromSuperview()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Breeds"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

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
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.cellForRow(at: indexPath)?.textLabel?.text)
        if isFiltering {
            selectedBreedID = breedsListFiltered[indexPath.row].id
        } else {
            selectedBreedID = breedsList[indexPath.row].id
        }
        performSegue(withIdentifier: "toBreedDetails", sender: self)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toBreedDetails" else {return}
        guard let destination = segue.destination as? BreedDetailsViewController else {
            return
        }
        
        destination.breedID = selectedBreedID
    }
    

}

//MARK: - Breed Search
extension BreedsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForeSearchText(searchBar.text!)
    }
    
    func filterContentForeSearchText(_ searchText: String){
        breedsListFiltered = breedsList.filter({ (breedName) -> Bool in
            return breedName.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
