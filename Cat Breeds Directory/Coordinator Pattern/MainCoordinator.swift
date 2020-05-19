//
//  MainCoordinator.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 18.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BreedsListViewController.instantiate()
        vc.mainCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func displayBreedDetails(breedID: String) {
        let vc = BreedDetailsViewController.instantiate()
        vc.mainCoordinator = self
        vc.breedID = breedID
        navigationController.pushViewController(vc, animated: true)
    }
}
