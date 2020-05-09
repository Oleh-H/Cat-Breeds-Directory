//
//  BreedDetailsViewController.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 05.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class BreedDetailsViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var catsImage: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    
    @IBOutlet weak var nameDescription: UILabel!
    @IBOutlet weak var valueDescription: UILabel!
    
    @IBOutlet weak var nameTemperament: UILabel!
    @IBOutlet weak var valueTemperament: UILabel!
    
    @IBOutlet weak var nameOrigin: UILabel!
    @IBOutlet weak var valueOrigin: UILabel!
    
    @IBOutlet weak var nameLifeSpan: UILabel!
    @IBOutlet weak var valueLifeSpan: UILabel!
    
    @IBOutlet weak var nameIndor: UILabel!
    @IBOutlet weak var valueIndor: UILabel!
    
    @IBOutlet weak var nameAdaptability: UILabel!
//    @IBOutlet weak var valueAdaptability: UILabel!
    @IBOutlet weak var valueAdaptabilityProgress: UIProgressView!
    @IBOutlet weak var valueAdaptabilityLabel: UILabel!
    
    
    //MARK: - Properties
    let networkManager = NetworkManager()
    let emojiManager = EmojiManager()
    
    var breedID: String = ""
    var breedDetails: [BreedDetails] = []
    let noInfo = "no information available"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catsImage.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        catsImage.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        catsImage.layer.shadowRadius = CGFloat(5.0)
        catsImage.layer.shadowOpacity = 0.7
        catsImage.layer.masksToBounds = false
        
//        imageContainerView.layer.cornerRadius = 15
//        catsImage.clipsToBounds = true
//        catsImage.layer.cornerRadius = 15
        
        navigationController?.navigationBar.prefersLargeTitles = false
        networkManager.getBreedDetails(breedID: breedID) { [weak self] details in
            print(self?.breedID)
            self?.breedDetails = details
            self?.updateUI(details: details)
        }
    }
    
    func updateUI(details: [BreedDetails]) {
        if let imageURL = details.first?.url {
            networkManager.getImage(imageURL: imageURL) { (image) in
                DispatchQueue.main.async {
                    self.catsImage.image = image
                    if let breed: Breed = self.breedDetails.first?.breeds.first {
                        self.breedName.text = breed.name
//                        self.navigationItem.title = breed.name
                        self.nameDescription.text = "Description:"
                        self.valueDescription.text = breed.description
                        
                        self.nameTemperament.text = "Temperament:"
                        self.valueTemperament.text = breed.temperament
                        
                        self.nameOrigin.text = "Origin:"
                        self.valueOrigin.text = "\(breed.origin ?? self.noInfo) \(self.emojiManager.emojiFlag(regionCode: breed.countryCode ?? "") ?? "")"
                        
                        self.nameLifeSpan.text = "Life Span:"
                        self.valueLifeSpan.text = {
                            if let lifeSpan = breed.lifeSpan {
                                return "\(lifeSpan) years"
                            } else {
                                return self.noInfo
                            }
                        }()
                        
                        self.nameIndor.text = "Indor:"
                        self.valueIndor.text = self.binaryToYesNo(number: breed.indoor)
                        
                        self.nameAdaptability.text = "Adaptability:"
                        if let adaptability = breed.adaptability {
                            let progressLevel = self.intToProgressLevel(level: adaptability)
                            self.valueAdaptabilityProgress.setProgress(progressLevel.level, animated: false)
                            self.valueAdaptabilityProgress.tintColor = progressLevel.color
                        } else {
                            self.valueAdaptabilityProgress.isHidden = true
                            self.valueAdaptabilityLabel.isHidden = false
                            self.valueAdaptabilityLabel.text = self.noInfo
                        }
                    }
                }
            }
        }
    }
    
    func binaryToYesNo(number: Int?) -> String {
        guard let binar = number else { return noInfo }
        switch binar {
        case 1:
            return "Yes"
        default:
            return "No"
        }
    }
    
    func intToProgressLevel(level: Int) -> (level: Float, color:UIColor) {
        switch level {
        case 0:
            return (0.0, UIColor.systemRed)
        case 1:
            return (0.2, UIColor.systemRed)
        case 2:
            return (0.4, UIColor.systemYellow)
        case 3:
            return (0.6, UIColor.systemYellow)
        case 4:
            return (0.8, UIColor.systemGreen)
        default:
            return (1.0, UIColor.systemGreen)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
