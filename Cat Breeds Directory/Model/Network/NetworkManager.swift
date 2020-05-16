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
    let jsonDataParser = JsonDataParser()
    
    func getBreedDetails(breedID: String, completion: @escaping ([BreedDetails]) -> Void ) {
        let catApiBreed: String = "\(Constants.catApiUrl)images/search?breed_id=\(breedID)"
        guard let url = URL(string: catApiBreed) else {return}
        var request = URLRequest(url: url)
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.httpHeaterFieldForApiKey)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let breedsDetails = self.jsonDataParser.parseDataToBreedDetails(data)
                completion(breedsDetails)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getImage(imageURL: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        var request = URLRequest(url: url)
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.httpHeaterFieldForApiKey)
        
        let task = URLSession.shared.dataTask(with: request) { data, respomse, error in
            if let data = data {
                let image = UIImage(data: data)
                completion(image!)
            }
        }
        task.resume()
    }
}
