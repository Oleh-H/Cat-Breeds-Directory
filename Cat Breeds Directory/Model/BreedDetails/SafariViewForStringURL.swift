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
    
    ///Init and return `SFsafariViewController` called on URL sring.
    ///
    ///If string can't be converted to url correctly function returns standart page determined in `Constants` struct.
    func urlToSafariViewController() -> SFSafariViewController? {
        guard let url = URL.init(string: self) else { return nil }
        let safariViewController = SFSafariViewController(url: url)
        return safariViewController
    }
}
