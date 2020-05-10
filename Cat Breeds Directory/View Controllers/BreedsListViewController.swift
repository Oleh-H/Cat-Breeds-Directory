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
    var breedsList: [BreedForTable] = []
    var selectedBreedID: String = ""
    
    //MARK: - ViewControllerLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedsList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedsList", for: indexPath)

        cell.textLabel?.text = breedsList[indexPath.row].name

        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        selectedBreedID = breedsList[indexPath.row].id
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
