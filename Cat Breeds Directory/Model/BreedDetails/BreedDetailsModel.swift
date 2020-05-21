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

    
    private let emojiManager = EmojiManager()
    private let progressDisplayingStackView = ProgressDisplayingStackView()
    private let network = BreedDetailsNetwork()
    private var breed: Breed?
    
    //MARK: - Get data
    func preparedDataForUI(breedID: String, handler: @escaping (Result<([String: String], [String: UIStackView], [String: String], [String?], UIImage), Error>) -> Void) {
        network.getBreedDetails(breedID: breedID) { (result) in
            switch result {
            case .success(let breedDetails):
                guard let breed = breedDetails.first?.breeds.first else {return}
                self.breed = breed
                let labels = self.textLabelsReadyToDisplay(breed: breed)
                let stackViews =  self.readyProgressViewStack(breed: breed)
                let yesNoLabels = self.readyYesNoLabels(breed: breed)
                let links = self.linksForExternalResouses(breed:breed)

                self.network.getImage(url: breedDetails.first?.url) { (image) in
                switch image {
                case .success(let catImage):
                    handler(.success((labels, stackViews, yesNoLabels, links, catImage)))
                case .failure(let error):
                    handler(.failure(error))
                    }
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    //MARK: Prepare data for UI
    private func textLabelsReadyToDisplay(breed: Breed) -> [String: String] {
        var textLabels: [String: String] = [:]
        
        textLabels["name"] = breed.name
        textLabels["temperament"] = breed.temperament
        
        let origin = breed.origin
        let flag = emojiManager.emojiFlag(regionCode: breed.countryCode)
        textLabels["origin"] = "\(origin ?? Constants.noInfoString) \(flag)"
        
        textLabels["description"] = breed.description
        
        if let lifeSpan = breed.lifeSpan {
            textLabels["lifeSpan"] = "\(lifeSpan) years"
        } else {
            textLabels["lifeSpan"] = Constants.noInfoString
        }
        
        let kgString = "\(breed.weight.metric ?? Constants.noInfoString) kg"
        let lbString = " (\(breed.weight.imperial ?? Constants.noInfoString) lb)"
        textLabels["weight"] = kgString + lbString
        
        return textLabels
    }
    
    private func readyProgressViewStack(breed: Breed) -> [String: UIStackView] {
        var stackWithProgressViews: [String: UIStackView] = [:]
        
        let mirror = Mirror(reflecting: breed)
        let array = Array(mirror.children)
        
        for valueName in Constants.valueNamesForStackViews {
            guard let property = array.first(where: {$0.label == valueName}) else { continue }
            
            let stack = progressDisplayingStackView.displayVauesFom1To5(value: property.value as? Int)
            stackWithProgressViews[valueName] = stack
        }
        
        return stackWithProgressViews
    }
    
    
    private func readyYesNoLabels(breed: Breed) -> [String: String] {
        var labels: [String: String] = [:]
        
        let mirror = Mirror(reflecting: breed)
        let array = Array(mirror.children)
        
        for valueName in Constants.valueNamesForYesNoLabels {
            guard let property = array.first(where: {$0.label == valueName}) else { continue }
            
            let label = StringBinar(binarInt: property.value as? Int).value
            labels[valueName] = label
        }
        
        return labels
    }
    
    //MARK: Links
    func linksForExternalResouses(breed: Breed) -> [String?]{
        let urls = [breed.cfaURL, breed.vcahospitalsURL, breed.vetstreetURL, breed.wikipediaURL]
        return urls
    }
    
    //MARK: Strings for sharing
    func stringForSharing() -> String {
        let name = breed!.name
        let temperament = breed?.temperament
        let description = breed?.description
        let origin = emojiManager.emojiFlag(regionCode: breed?.countryCode)
        let underlyingString = "\(name) \(origin)\n\nTemperament: \(temperament ?? "")\n\nDescription: \(description ?? "")"
        return underlyingString
    }
}
