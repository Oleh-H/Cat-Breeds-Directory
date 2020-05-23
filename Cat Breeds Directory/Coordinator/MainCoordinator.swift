//
//  MainCoordinator.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 18.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

///The `MainCoordinator` class manages navigation in the App's UI.
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    ///Receives a `UINavigationController` initialized at `SceneDelegate` class on app start.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BreedsListViewController.instantiate()
        vc.mainCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    ///Perform navigation to `BreedDetailsViewController`
    ///
    ///- Parameters:
    ///    - breedID: required for loading data of selected breed
    func displayBreedDetails(breedID: String) {
        let vc = BreedDetailsViewController.instantiate()
        vc.mainCoordinator = self
        vc.breedID = breedID
        navigationController.pushViewController(vc, animated: true)
    }
}
