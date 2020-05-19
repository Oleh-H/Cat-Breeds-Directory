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
        self.value = Float(intFrom0To5) / 5.0
    }
}
