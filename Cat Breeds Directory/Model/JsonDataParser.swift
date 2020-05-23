//
//  JsonDataParser.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 13.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

///Contains funcrions that parsing JSON data into determined type of data.
class JsonDataParser {
    
    ///Parse JSON data to `returnType:` type.
    ///
    ///- Note: Function used `.convertFromSnakeCase` key decoding strategy property for `JSONDecoder` instance.
    ///- Parameters:
    ///     - data: data in JSON format.
    ///     - returnType: data will be parsed into this type.
    func parseJSONData<T: Decodable>(_ data: Data, returnType: [T].Type) -> Result<[T], Error> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        var decodedBreeds: [T] = []
        do {
            decodedBreeds = try jsonDecoder.decode(returnType.self, from: data)
            return .success(decodedBreeds)
        } catch let error as NSError {
            return .failure(error)
        }
    }
    
}
