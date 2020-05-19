//
//  JsonDataParser.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 13.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
/**
 Contains parsers of JSON data into determined type of data.
 */
class JsonDataParser {
    
    
    func parseDataToBreedsList(_ data: Data) -> Result<[BreedIdAndName], Error> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        var decodedBreeds: [BreedIdAndName] = []
        do {
            decodedBreeds = try jsonDecoder.decode([BreedIdAndName].self, from: data)
            return .success(decodedBreeds)
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
            return .failure(error)
        }
    }

    func parseDataToBreedDetails(_ data: Data) -> Result<[BreedDetails], Error> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        var decodedBreeds: [BreedDetails] = []
        do {
            decodedBreeds = try jsonDecoder.decode([BreedDetails].self, from: data)
            return .success(decodedBreeds)
        } catch let error as NSError {
            return .failure(error)
        }
    }
}
