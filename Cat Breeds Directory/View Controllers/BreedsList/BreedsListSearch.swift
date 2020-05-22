//
//  BreedsListSearch.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 15.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Breed Search
extension BreedsListViewController {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForeSearchText(searchBar.text!)
    }
    ///Display in table only names that match the search phrase.
    func filterContentForeSearchText(_ searchText: String){
        breedsListFiltered = breedsList.filter({ (breedName) -> Bool in
            return breedName.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
