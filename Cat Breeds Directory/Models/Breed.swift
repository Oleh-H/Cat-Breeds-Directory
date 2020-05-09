//
//  Breed.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 03.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation


struct Breed: Decodable {
    let weight: Weight
    let id: String
    let name: String
    let cfaURL: String? //The cat fanciers' association
    let vetstreetURL: String?
    let vcahospitalsURL: String?
    let temperament: String?
    let origin: String?
//    let country_codes: String?
    let countryCode: String?
    let description: String?
    let lifeSpan: String?
    let indoor: Int?
    //let lap: Int
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
    //let natural: Int
    let rare: Int?
    let rex: Int? //king
    let suppressedTail: Int?
    let shortLegs: Int?
    let wikipediaURL: String?
    let hypoallergenic: Int?
    
    enum CodingKeys: String, CodingKey {
        case weight = "weight"
        case id = "id"
        case name = "name"
        case cfaURL = "cfa_url"
        case vetstreetURL = "vetstreet_url"
        case vcahospitalsURL = "vcahospitals_url"
        case temperament = "temperament"
        case origin = "origin"
    //    case country_codes: String?
        case countryCode = "country_code"
        case description = "description"
        case lifeSpan = "life_span"
        case indoor = "indoor"
        //let lap: Int
        case altNames = "alt_names"
        case adaptability = "adaptability"
        case affectionLevel = "affection_level"
        case catFriendly = "cat_friendly"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming = "grooming"
        case healthIssues = "health_issues"
        case intelligence = "intelligence"
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation = "vocalisation"
        case experimental = "experimental"
        case hairless = "hairless"
        //let natural: Int
        case rare = "rare"
        case rex = "rex"
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaURL = "wikipedia_url"
        case hypoallergenic = "hypoallergenic"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.weight = try valueContainer.decode(Weight.self, forKey: CodingKeys.weight)
        self.id = try valueContainer.decode(String.self, forKey: CodingKeys.id)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.cfaURL = try? valueContainer.decode(String.self, forKey: CodingKeys.cfaURL)
        self.vetstreetURL = try? valueContainer.decode(String.self, forKey: CodingKeys.vetstreetURL)
        self.vcahospitalsURL = try? valueContainer.decode(String.self, forKey: CodingKeys.vcahospitalsURL)
        self.temperament = try? valueContainer.decode(String.self, forKey: CodingKeys.temperament)
        self.origin = try? valueContainer.decode(String.self, forKey: CodingKeys.origin)
        self.countryCode = try? valueContainer.decode(String.self, forKey: CodingKeys.countryCode)
        self.description = try? valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.lifeSpan = try? valueContainer.decode(String.self, forKey: CodingKeys.lifeSpan)
        self.indoor = try? valueContainer.decode(Int.self, forKey: CodingKeys.indoor)
        self.altNames = try? valueContainer.decode(String.self, forKey: CodingKeys.altNames)
        self.adaptability = try? valueContainer.decode(Int.self, forKey: CodingKeys.adaptability)
        self.affectionLevel = try? valueContainer.decode(Int.self, forKey: CodingKeys.affectionLevel)
        self.catFriendly = try? valueContainer.decode(Int.self, forKey: CodingKeys.catFriendly)
        self.childFriendly = try? valueContainer.decode(Int.self, forKey: CodingKeys.childFriendly)
        self.dogFriendly = try? valueContainer.decode(Int.self, forKey: CodingKeys.dogFriendly)
        self.energyLevel = try? valueContainer.decode(Int.self, forKey: CodingKeys.energyLevel)
        self.grooming = try? valueContainer.decode(Int.self, forKey: CodingKeys.grooming)
        self.healthIssues = try? valueContainer.decode(Int.self, forKey: CodingKeys.healthIssues)
        self.intelligence = try? valueContainer.decode(Int.self, forKey: CodingKeys.intelligence)
        self.sheddingLevel = try? valueContainer.decode(Int.self, forKey: CodingKeys.sheddingLevel)
        self.socialNeeds = try? valueContainer.decode(Int.self, forKey: CodingKeys.socialNeeds)
        self.strangerFriendly = try? valueContainer.decode(Int.self, forKey: CodingKeys.strangerFriendly)
        self.vocalisation = try? valueContainer.decode(Int.self, forKey: CodingKeys.vocalisation)
        self.experimental = try? valueContainer.decode(Int.self, forKey: CodingKeys.experimental)
        self.hairless = try? valueContainer.decode(Int.self, forKey: CodingKeys.hairless)
        self.rare = try? valueContainer.decode(Int.self, forKey: CodingKeys.rare)
        self.rex = try? valueContainer.decode(Int.self, forKey: CodingKeys.rex)
        self.suppressedTail = try? valueContainer.decode(Int.self, forKey: CodingKeys.suppressedTail)
        self.shortLegs = try? valueContainer.decode(Int.self, forKey: CodingKeys.shortLegs)
        self.wikipediaURL = try? valueContainer.decode(String.self, forKey: CodingKeys.wikipediaURL)
        self.hypoallergenic = try? valueContainer.decode(Int.self, forKey: CodingKeys.hypoallergenic)
    }
}

struct Weight: Decodable {
    let imperial: String?
    let metric: String?
}
