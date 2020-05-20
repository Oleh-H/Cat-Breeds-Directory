//
//  SafariViewForStringURL.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 20.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import SafariServices

extension String {
    //MARK: Safari View Controller
    
    /**
     
     */
    func urlToSafariViewController() -> SFSafariViewController {
        let url = URL(string: self)
        let safariViewController = SFSafariViewController(url: url!)
        return safariViewController
    }
}
