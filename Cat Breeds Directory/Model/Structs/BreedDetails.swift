//
//  BreedDetails.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 07.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

///Type, that defines needed properties for decoding data received on image request by breed id.
struct BreedDetails: Decodable {
    let breeds: [Breed]
    ///Image ID
    let id: String
    ///Image URL
    let url: String
}
