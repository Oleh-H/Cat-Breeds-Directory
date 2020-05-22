//
//  BreedsListTableView.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 20.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

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
        var selectedBreedID = ""
        if isFiltering {
            selectedBreedID = breedsListFiltered[indexPath.row].id
        } else {
            selectedBreedID = breedsList[indexPath.row].id
        }
        // MARK: - Navigation
        mainCoordinator?.displayBreedDetails(breedID: selectedBreedID)
    }
}
