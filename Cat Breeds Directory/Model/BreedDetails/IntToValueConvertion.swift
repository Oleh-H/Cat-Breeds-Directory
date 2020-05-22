//
//  IntToValueConvertion.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 14.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
///Converts `Int` of 1 or 0 to corresponding string "Yes" or "No".
///
///- Note: property `value` contains resulting string
struct StringBinar {
    var value: String?
    
    init(binarInt: Int?) {
        if binarInt == 0 || binarInt == 1 {
            self.value = binarInt == 1 ? "Yes" : "No"
        } else {
            self.value = nil
        }
    }
}

///Converts Int into Float as part of 100% according to set `maxNumberForRange`
///
///For example 4 of maximal amount 5 as 100% will be equal 4 / 5 = 0,8 or 80%
///In current configuration range is set from 0 to 5.
///
///- Note: property `value` contains resulting string
struct IntDecimal {
    var value: Float
    
    init(intFrom0To5: Int) {
        self.value = Float(intFrom0To5) / Constants.maxNumberForRange
    }
}
