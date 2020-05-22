//
//  BreedForTable.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 07.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

///Type, that contains two parameters *(skip excessive data)*. `name` used for displaying breed names as a list. `id` used for identifying selected breed.
struct BreedIdAndName: Decodable {
    let id: String
    let name: String
}
