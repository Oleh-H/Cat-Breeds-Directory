//
//  NetworkManager.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 03.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    //MARK: - Properties
    let catApiUrl = "https://api.thecatapi.com/v1/"
    let apiKey = "6500c584-7d69-4cb5-8cd6-c807b1dfc2c9"
    let httpHeaterFieldForApiKey = "x-api-key"
    
    var breedsList: [BreedForTable] = []
    var breedsDetails: [BreedDetails] = []

    typealias BreedsList = ([BreedForTable]) -> Void

    
    
    func getBreedsList(completion: @escaping BreedsList) {
        let catApiBreeds: String = "\(catApiUrl)breeds"
        guard let url = URL(string: catApiBreeds) else {return}
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: httpHeaterFieldForApiKey)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
//                let string = String(bytes: data, encoding: .utf8)
                self.parseDataToBreedsList(data)

                completion(self.breedsList)
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getBreedDetails(breedID: String, completion: @escaping ([BreedDetails]) -> Void ) {
        let catApiBreed: String = "\(catApiUrl)images/search?breed_id=\(breedID)"
        guard let url = URL(string: catApiBreed) else {return}
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: httpHeaterFieldForApiKey)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let string = String(bytes: data, encoding: .utf8)
                print(string)
                self.parseDataToBreedDetails(data)
                
                completion(self.breedsDetails)
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getImage(imageURL: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: httpHeaterFieldForApiKey)
        
        let task = URLSession.shared.dataTask(with: request) { data, respomse, error in
            if let data = data {
                let image = UIImage(data: data)
                completion(image!)
            }
        }
        task.resume()
    }
    
    func parseDataToBreedsList(_ data: Data) {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedBreeds = try jsonDecoder.decode([BreedForTable].self, from: data)
            breedsList = decodedBreeds
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func parseDataToBreedDetails(_ data: Data) {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedBreeds = try jsonDecoder.decode([BreedDetails].self, from: data)
            breedsDetails = decodedBreeds
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
