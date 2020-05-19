//
//  BreedDetailsModel.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 15.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
//import UIKit
import SafariServices

class BreedDetailsModel {
    
    //MARK: Properties

    let jsonDataParser = JsonDataParser()

    //MARK: - Network
    
    
    func getBreedDetails(breedID: String, completion: @escaping (Result<[BreedDetails], Error>) -> Void ) {
        let catApiBreed: String = "\(Constants.catApiUrl)images/search?breed_id=\(breedID)"
        guard let url = URL(string: catApiBreed) else {return}
        var request = URLRequest(url: url)
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.httpHeaterFieldForApiKey)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let breedsDetails = self.jsonDataParser.parseDataToBreedDetails(data)
                switch breedsDetails {
                case .success(let details):
                    completion(.success(details))
                case .failure(let error):
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    
    func getImage(imageURL: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        var request = URLRequest(url: url)
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.httpHeaterFieldForApiKey)
        
        let task = URLSession.shared.dataTask(with: request) { data, respomse, error in
            if let data = data {
                let image = UIImage(data: data)
                completion(.success(image!))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getAnotherImage(breedID: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        getBreedDetails(breedID: breedID) { (details) in
            switch details {
            case .success(let details):
                guard let imageURL = details.first?.url else {return}
                self.getImage(imageURL: imageURL) { (image) in
                    switch image {
                    case .success(let image):
                        completion(.success(image))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    /**
     Check if string exists, and return `Bool`
     - !nil = true
     - nil = false
     */
    func ifStringIsNotNil(string: String?) -> Bool {
        guard string != nil else {return false}
        return true
    }
    
    //MARK: Safari View Controller
    
    /**
     
     */
    func presentSafariVC(urlString: String?, handler: (SFSafariViewController) -> Void){
        let url = URL(string: urlString!)
        let safariViewController = SFSafariViewController(url: url!)
        handler(safariViewController)
    }
}
