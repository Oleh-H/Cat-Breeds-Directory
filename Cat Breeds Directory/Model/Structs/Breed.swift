//
//  Breed.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 03.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

///Type that defines all properties of breed need for decoding saving data received from API.
///
///Also, it contains `enum CodingKeys` for specialcases in transformation properties name from **snake_case** to **CamelCase** using `.keyDecodingStrategy` property of `JsonDecoer` class instance.
struct Breed: Decodable {
    let weight: Weight
    let id: String
    let name: String
    let cfaURL: String? //The cat fanciers' association
    let vetstreetURL: String?
    let vcahospitalsURL: String?
    let temperament: String?
    let origin: String?
    let countryCode: String?
    let description: String?
    let lifeSpan: String?
    let indoor: Int?
    let altNames: String? //skipped
    let adaptability: Int?
    let affectionLevel: Int? //level of favor
    let catFriendly: Int?
    let childFriendly: Int?
    let dogFriendly: Int?
    let energyLevel: Int?
    let grooming: Int? //look after
    let healthIssues: Int?
    let intelligence: Int?
    let sheddingLevel: Int? //level of hair loss
    let socialNeeds: Int?
    let strangerFriendly: Int?
    let vocalisation: Int?
    let experimental: Int?
    let hairless: Int?
    let rare: Int?
    let rex: Int? //king
    let suppressedTail: Int?
    let shortLegs: Int?
    let wikipediaURL: String?
    let hypoallergenic: Int?
    
    enum CodingKeys: String, CodingKey {
        case weight
        case id
        case name
        case cfaURL = "cfaUrl"
        case vetstreetURL = "vetstreetUrl"
        case vcahospitalsURL = "vcahospitalsUrl"
        case temperament
        case origin
        case countryCode
        case description
        case lifeSpan
        case indoor
        case altNames
        case adaptability
        case affectionLevel
        case catFriendly
        case childFriendly
        case dogFriendly
        case energyLevel
        case grooming
        case healthIssues
        case intelligence
        case sheddingLevel
        case socialNeeds
        case strangerFriendly
        case vocalisation
        case experimental
        case hairless
        case rare
        case rex
        case suppressedTail
        case shortLegs
        case wikipediaURL = "wikipediaUrl"
        case hypoallergenic
    }
}

struct Weight: Decodable {
    let imperial: String?
    let metric: String?
}
