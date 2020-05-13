//
//  JsonDataParser.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 13.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

class JsonDataParser {
    func parseDataToBreedsList(_ data: Data) -> [BreedIdAndName] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        var decodedBreeds: [BreedIdAndName] = []
        do {
            decodedBreeds = try jsonDecoder.decode([BreedIdAndName].self, from: data)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return decodedBreeds
    }

    func parseDataToBreedDetails(_ data: Data) -> [BreedDetails] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        var decodedBreeds: [BreedDetails] = []
        do {
            decodedBreeds = try jsonDecoder.decode([BreedDetails].self, from: data)
            return decodedBreeds
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return decodedBreeds
    }
}
