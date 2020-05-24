//
//  Environment.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 13.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
///Contains constants properties available for all project.
struct Constants {
    static let catApiUrl = "https://api.thecatapi.com/v1/"
    static let apiKey = "6500c584-7d69-4cb5-8cd6-c807b1dfc2c9"
    static let httpHeaterFieldForApiKey = "x-api-key"
    ///Standart URL used in case url string of external resources can't be successfully converted to `URL` type.
    static let googleSearchBreedsURL = "https://bit.ly/2Tp027d"
    ///Max number for range for some values of [breed] that is in JSON responce from API.
    static let maxNumberForRange: Float = 5.0
    ///Names of values that should be created as UIStackViews that contains progress view.
    static let valueNamesForStackViews = ["adaptability", "affectionLevel", "catFriendly", "childFriendly", "dogFriendly", "energyLevel", "grooming", "healthIssues", "intelligence", "sheddingLevel", "socialNeeds", "strangerFriendly", "vocalisation"]
    
    ///Names of values that should be created as Labels with "Yes" / "No" strings.
    static let valueNamesForYesNoLabels = ["indoor", "experimental", "hairless", "rare", "rex", "suppressedTail", "shortLegs", "hypoallergenic"]
}

struct Strings {
    //UI strings
    static let noInfoString = "No information available"
    static let searchPlaceHolder = "Search breeds"
    static let errorAlertTitle = "Error"
    static let errorAlertButton = "Reload"
    static let errorMessageForBrokenLinks = "Sorry, this link is broken."
    
}
