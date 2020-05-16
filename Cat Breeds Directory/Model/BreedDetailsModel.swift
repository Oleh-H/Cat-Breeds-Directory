//
//  BreedDetailsModel.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 15.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

class BreedDetailsModel {
    
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
    
//    //MARK: - Support func for UI update
//
//    // set value to progress view if value is not nil. If it is nil, function hide progressView, labels 0 and 5 and displays no info label
//    func setValueToProgressView(value: Int?, progressView: UIProgressView, noInfolabel: UILabel, zeroFiveLabelsNumber: Int) {
//        guard let value = value else {
//            progressView.isHidden = true
//            zeroLabel[zeroFiveLabelsNumber].isHidden = true
//            fiveLabel[zeroFiveLabelsNumber].isHidden = true
//            noInfolabel.isHidden = false
//            noInfolabel.text = self.noInfo
//            return
//        }
//        let progressLevel = IntDecimal(intFrom0To5: value)
//        progressView.setProgress(progressLevel.value, animated: false)
//    }
//    
//    func <#name#>(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
    
    
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
