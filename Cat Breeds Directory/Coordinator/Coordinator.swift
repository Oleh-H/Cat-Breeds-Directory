//
//  Coordinator.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 18.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit


///Types adopting the `Coordinator` protocol can use MainCoordinator class for performing navigation between UIViewControllers.
///
///For using `Coordinator` all UIViewControllers in FileName.storyboard file must have filler "StoryboardID" field for instantiating UIViewController in MainCoordinator class. Also all UIViewController classes should have property `weak var mainCoordinator: MainCoordinator?`, and `self` should be set to this property in every function for navigaion in MainCoordinator.
protocol Coordinator {
    ///Contains UINavigarionController of the app
    ///
    ///It initializes on the app start in SceneDelegate class
    var navigationController: UINavigationController {get set}
    
    ///This func should push initial UIViewController onto the stack.
    ///
    ///It calls on app start at SceneDelegate class.
    func start()
}
