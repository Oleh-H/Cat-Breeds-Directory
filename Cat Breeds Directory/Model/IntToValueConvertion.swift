//
//  IntToValueConvertion.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 14.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

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

struct IntDecimal {
    var value: Float
    
    init(intFrom0To5: Int) {
        switch intFrom0To5 {
        case 0:
            value = 0.0
        case 1:
            value = 0.2
        case 2:
            value = 0.4
        case 3:
            value = 0.6
        case 4:
            value = 0.8
        case 5:
            value = 1.0
        default:
            value = 0.0
        }
    }
}
