//
//  BreedListModel.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 15.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

class BreedListModel {
    
    //MARK: - Properties
    let jsonDataParser = JsonDataParser()
    typealias BreedsList = (Result<[BreedIdAndName], Error>) -> Void

    
    func getBreedsList(completion: @escaping BreedsList) {
        let catApiBreeds: String = "\(Constants.catApiUrl)breeds"
        guard let url = URL(string: catApiBreeds) else {return}
        var request = URLRequest(url: url)
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.httpHeaterFieldForApiKey)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
//                let string = String(bytes: data, encoding: .utf8)
                let breedsList = self.jsonDataParser.parseDataToBreedsList(data)
                switch breedsList {
                case .success(let list):
                    completion(.success(list))
                case .failure(let error):
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
