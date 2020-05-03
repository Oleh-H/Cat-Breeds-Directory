//
//  Beerds.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 03.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation


struct Breed: Decodable {
    let id: String
    let name: String
    let temperament: String
    let life_span: String
}
