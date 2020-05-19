//
//  Coordinator.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 18.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    
    func start()
}
