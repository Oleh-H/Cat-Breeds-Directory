//
//  BreedDetails.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 07.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

struct BreedDetails: Decodable {
    let breeds: [Breed]
    let id: String
    let url: String
}
