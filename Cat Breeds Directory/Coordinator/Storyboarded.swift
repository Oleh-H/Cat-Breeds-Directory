//
//  Storyboarded.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 18.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

///Type adopting the `Storyboarded` protocol can be used for instantiating UIViewControllers by it's class name.
///
///It's `instantiete() -> Self` function should returns UIViewController called on ClassNameUIViewController.
protocol Storyboarded {
    ///Current finction applied on class name return current UIViewController
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController{

    static func instantiate() -> Self {
        ///Contains AppName.ViewControllerName. If aClass is nil returns nil
        let fullName = NSStringFromClass(self)
        ///Contains ViewController class name as `String`
        let className = fullName.components(separatedBy: ".")[1]
        ///Contains Main UIStoryboard object.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        ///Returns  UIViewController on which function was called
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
