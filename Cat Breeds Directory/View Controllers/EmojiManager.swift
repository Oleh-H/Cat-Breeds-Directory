//
//  EmojiManager.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 08.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

class EmojiManager {
    
    func emojiFlag(regionCode: String) -> String? {
        let code = regionCode.uppercased()

        guard Locale.isoRegionCodes.contains(code) else {
            return nil
        }

        var flagString = ""
        for s in code.unicodeScalars {
            guard let scalar = UnicodeScalar(127397 + s.value) else {
                continue
            }
            flagString.append(String(scalar))
        }
        return flagString
    }
}
