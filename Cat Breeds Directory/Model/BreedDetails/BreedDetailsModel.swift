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

///Constructs data of breed description and breed image received from API for setting it to ui elements.
class BreedDetailsModel {
    
    //MARK: Properties

    
    private let emojiManager = EmojiManager()
    private let progressDisplayingStackView = ProgressDisplayingStackView()
    private let network = BreedDetailsNetwork()
    private var breed: Breed?
    ///Type of Void function with `Result` type parameter.
    ///
    ///Contains .success data type as typle of dictionaries for: labels, stackViews, yesNoLabels, links and one Image.
    typealias DataForUIElements = (Result<([String: String], [String: UIStackView], [String: String], [String?], UIImage), Error>) -> Void
    
    //MARK: - Get data
    ///
    func preparedDataForUI(breedID: String, handler: @escaping DataForUIElements)  {
        network.getBreedDetails(breedID: breedID) { (result) in
            switch result {
            case .success(let breedDetails):
                DispatchQueue.main.async {
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
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    //MARK: Prepare data for UI
    ///Prepare strings contained in received argument for setting ti the labels
    ///
    ///- Returns: Dictionary of label name and prepared string for it.
    private func textLabelsReadyToDisplay(breed: Breed) -> [String: String] {
        var textLabels: [String: String] = [:]
        
        textLabels["name"] = breed.name
        textLabels["temperament"] = breed.temperament
        
        let origin = breed.origin
        let flag = emojiManager.emojiFlag(regionCode: breed.countryCode)
        textLabels["origin"] = "\(origin ?? Strings.noInfoString) \(flag)"
        
        textLabels["description"] = breed.description
        
        if let lifeSpan = breed.lifeSpan {
            textLabels["lifeSpan"] = "\(lifeSpan) years"
        } else {
            textLabels["lifeSpan"] = Strings.noInfoString
        }
        
        let kgString = "\(breed.weight.metric ?? Strings.noInfoString) kg"
        let lbString = " (\(breed.weight.imperial ?? Strings.noInfoString) lb)"
        textLabels["weight"] = kgString + lbString
        
        return textLabels
    }
    ///Create dictionary of `UIStackView` instances with range as `UILabels` and progress in this range as `UIProgressView`
    ///
    ///Function get values for dedicated in `Constants` keys brom `breed` property for preparing ready to display UIStackViews with content.
    ///- Returns: Dictionary that contain name and UIStackView with initialized and appended all dedicated elements.
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
    
    ///Creates dictionary with "Yes", "No" labels for dedicated in `Constants` propery names
    ///
    ///- Returns: Dictionary of property name and "Yes" or "No" string.
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
    ///- Returns: Array of url liks as String for external info resouces for the breed.
    func linksForExternalResouses(breed: Breed) -> [String?]{
        let urls = [breed.cfaURL, breed.vcahospitalsURL, breed.vetstreetURL, breed.wikipediaURL]
        return urls
    }
    
    //MARK: Strings for sharing
    ///Combain several sections of breed description into one string ready for sharing.
    func stringForSharing() -> String {
        let name = breed!.name
        let temperament = breed?.temperament
        let description = breed?.description
        let origin = emojiManager.emojiFlag(regionCode: breed?.countryCode)
        let underlyingString = "\(name) \(origin)\n\nTemperament: \(temperament ?? "")\n\nDescription: \(description ?? "")"
        return underlyingString
    }
}
