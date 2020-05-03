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
    private let catApiURL: String = "https://api.thecatapi.com/v1/"
    
    func fetchBreeds() {
        let breeds = "breeds"
        let urlString = catApiURL + breeds
        performRequest(withURLString: urlString)
    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.addValue("6500c584-7d69-4cb5-8cd6-c807b1dfc2c9", forHTTPHeaderField: "x-api-key")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                self.parseJson(data: data)
            }
        }
        task.resume()
    }
    
    fileprivate func parseJson(data: Data) {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try jsonDecoder.decode([Breed].self, from: data)
            print(jsonData.first)
        } catch let error as NSError {
            print(error)
        }
    }
}
