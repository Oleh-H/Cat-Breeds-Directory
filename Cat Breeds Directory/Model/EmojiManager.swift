//
//  EmojiManager.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 08.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

/// Displaying emoji in strings.
class EmojiManager {
    
    /**
    Convert region code String into corresponding region flag emoji.
     
     Calling this metod receive region code like `US`, make it uppercased and validate it using `Locale.isoRegionCodes`. If code vas succesfully validated it transforms into string of Unicode scalars. This sring is returned by the function.
     
     - Parameters:
        - regionCode: region code `String`
     
     - Returns: Emoji flag of the region
     */
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
