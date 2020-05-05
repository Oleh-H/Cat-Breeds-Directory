//
//  NetworkManager.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 03.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation

class NetworkManager {
    
    //MARK: - Properties
    let catApiUrl = "https://api.thecatapi.com/v1/"
    let apiKey = "6500c584-7d69-4cb5-8cd6-c807b1dfc2c9"
    let httpHeaterFieldForApiKey = "x-api-key"
    
    var breedsList: [Breed] = []

    typealias BreedsList = ([Breed]) -> Void

    
    
    func breeds(completion: @escaping BreedsList) {
        let catApiBreed: String = "\(catApiUrl)breeds"
        guard let url = URL(string: catApiBreed) else {return}
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: httpHeaterFieldForApiKey)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
//                let string = String(bytes: data, encoding: .utf8)
                self.parseDataToBreedsList(data)
                DispatchQueue.main.async {
                    completion(self.breedsList)
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func performRequest(completion: @escaping BreedsList ) {
        let catApiBreed: String = "https://api.thecatapi.com/v1/breeds"
        guard let url = URL(string: catApiBreed) else {return}
        var request = URLRequest(url: url)
        request.addValue("6500c584-7d69-4cb5-8cd6-c807b1dfc2c9", forHTTPHeaderField: "x-api-key")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
//                let string = String(bytes: data, encoding: .utf8)
                self.parseDataToBreedsList(data)
                DispatchQueue.main.async {
                    completion(self.breedsList)
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func parseDataToBreedsList(_ data: Data) {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedBreeds = try jsonDecoder.decode([Breed].self, from: data)
            breedsList = decodedBreeds
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
