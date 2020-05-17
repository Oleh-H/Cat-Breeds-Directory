//
//  BreedDetailsModel.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 15.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class BreedDetailsModel {
    
//MARK: Properties
    
    let noInfoString = "No information available"

    var label0: UILabel {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }
    
    var label5: UILabel {
        let label = UILabel()
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }
    
    
    func displayVauesFom1To5(value: Int?) -> UIStackView {
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 8
            return stack
        }()
        
        let progressView = UIProgressView()
        guard let value = value else {
            let noInfo = setNoInfoLabelToStack()
            return noInfo
        }
        progressView.setProgress(setValueToProgressView(value: value), animated: false)
        stackView.addArrangedSubview(label0)
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(label5)
        return stackView
    }
    
    private func setValueToProgressView(value: Int) -> Float {
        let result = IntDecimal(intFrom0To5: value)
        return result.value
    }
    
    private func setNoInfoLabelToStack() -> UIStackView {
        let noInfoLabel: UILabel = {
            let label = UILabel()
            label.text = noInfoString
            return label
        }()
        
        let stackView: UIStackView = {
                   let stack = UIStackView()
                   stack.axis = .horizontal
                   stack.alignment = .center
                   stack.spacing = 8
                   return stack
               }()
        
        stackView.addArrangedSubview(noInfoLabel)
        return stackView
    }

    //MARK: - Network
    
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
    
    func getAnotherImage(breedID: String, completion: @escaping (UIImage) -> Void) {
        getBreedDetails(breedID: breedID) { (details) in
            guard let imageURL = details.first?.url else {return}
            self.getImage(imageURL: imageURL) { (image) in
                completion(image)
            }
        }
    }
    
    
    //MARK: Safari View Controller
    /**
     Check if string exists and return `Bool`
     - !nil = true
     - nil = false
     */
    func ifStringIsNotNil(string: String?) -> Bool {
        guard string != nil else {return false}
        return true
    }
    
    /**
     Return Safari ViewController with added `URL`
     */
    func prepareSafariVCForUrl(url: String) -> SFSafariViewController {
        let url = URL(string: url)
        let safariViewController = SFSafariViewController(url: url!)
        return safariViewController
    }
}
