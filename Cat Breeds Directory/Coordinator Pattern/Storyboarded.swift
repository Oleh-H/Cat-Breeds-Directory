//
//  Storyboarded.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 18.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController{
    ///Instantiate UIViewController with that identifier, and force cast it as type that was requested.
    static func instantiate() -> Self {
        ///Contains AppName.ViewControllerName. If aClass is nil returns nil
        let fullName = NSStringFromClass(self)
        ///Contains ViewController class name separated from AppName
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
