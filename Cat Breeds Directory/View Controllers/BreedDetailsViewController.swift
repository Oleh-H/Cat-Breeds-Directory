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
    @IBOutlet weak var valueAdaptabilityProgress: UIProgressView!
    @IBOutlet weak var valueAdaptabilityLabel: UILabel!
    
    @IBOutlet weak var nameAffection: UILabel!
    @IBOutlet weak var valueAffectionProgress: UIProgressView!
    @IBOutlet weak var valueAffectionLabel: UILabel!
    
    @IBOutlet weak var nameCatFriendly: UILabel!
    @IBOutlet weak var valueCatFriendlyProgress: UIProgressView!
    @IBOutlet weak var valueCatFriendlyLabel: UILabel!
    
    @IBOutlet weak var valueChildFriendlyProgress: UIProgressView!
    @IBOutlet weak var valueChildFriendlyLabel: UILabel!
    
    @IBOutlet weak var valueDogFriendlyProgress: UIProgressView!
    @IBOutlet weak var valueDogFriendlyLabel: UILabel!
    
    @IBOutlet weak var valueEnergyLevelProgress: UIProgressView!
    @IBOutlet weak var valueEnergyLevelLabel: UILabel!
    
    @IBOutlet var zeroLabel: [UILabel]!
    @IBOutlet var fiveLabel: [UILabel]!
    
    
    //MARK: - Properties
    let networkManager = NetworkManager()
    let emojiManager = EmojiManager()
    
    var breedID: String = ""
    var breedDetails: [BreedDetails] = []
    let noInfo = "No information available"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catsImage.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        catsImage.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        catsImage.layer.shadowRadius = CGFloat(5.0)
        catsImage.layer.shadowOpacity = 1.0
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
                        self.setValueToProgressView(value: breed.adaptability,
                                                    progressView: self.valueAdaptabilityProgress,
                                                    noInfolabel: self.valueAdaptabilityLabel,
                                                    zeroFiveLabelsNumber: 0)
                        
                        self.nameAffection.text = "Affection level:"
                        self.setValueToProgressView(value: breed.affectionLevel,
                                                    progressView: self.valueAffectionProgress,
                                                    noInfolabel: self.valueAffectionLabel,
                                                    zeroFiveLabelsNumber: 1)
                        
                        self.nameCatFriendly.text = "Cat friendly:"
                        self.setValueToProgressView(value: breed.catFriendly,
                                                    progressView: self.valueCatFriendlyProgress,
                                                    noInfolabel: self.valueCatFriendlyLabel,
                                                    zeroFiveLabelsNumber: 2)
                        //Child Friendly
                        self.setValueToProgressView(value: breed.childFriendly,
                                                    progressView: self.valueChildFriendlyProgress,
                                                    noInfolabel: self.valueChildFriendlyLabel,
                                                    zeroFiveLabelsNumber: 3)
                        //Dog Friendly
                        self.setValueToProgressView(value: breed.dogFriendly,
                                                    progressView: self.valueDogFriendlyProgress,
                                                    noInfolabel: self.valueDogFriendlyLabel,
                                                    zeroFiveLabelsNumber: 4)
                        //Energy Level
                        self.setValueToProgressView(value: breed.energyLevel,
                                                    progressView: self.valueEnergyLevelProgress,
                                                    noInfolabel: self.valueEnergyLevelLabel,
                                                    zeroFiveLabelsNumber: 5)
                        //Grooming
                        self.setValueToProgressView(value: breed.grooming, progressView: <#T##UIProgressView#>, noInfolabel: <#T##UILabel#>, zeroFiveLabelsNumber: <#T##Int#>)
                    }
                }
            }
        }
    }
    
    // set yes or no instead of 1 or 0 numbers
    func binaryToYesNo(number: Int?) -> String {
        guard let binar = number else { return noInfo }
        switch binar {
        case 1:
            return "Yes"
        default:
            return "No"
        }
    }
    
    
    //convert 0-5 int value to 1/5 progress steps
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
    
    
    // set value to progress view if value is not nil. If it is nil, function hide progressView, labels 0 and 5 and displays no info label
    func setValueToProgressView(value: Int?, progressView: UIProgressView, noInfolabel: UILabel, zeroFiveLabelsNumber: Int) {
        if let value = value {
            let progressLevel = intToProgressLevel(level: value)
            progressView.setProgress(progressLevel.level, animated: false)
            progressView.tintColor = progressLevel.color
        } else {
            progressView.isHidden = true
            zeroLabel[zeroFiveLabelsNumber].isHidden = true
            fiveLabel[zeroFiveLabelsNumber].isHidden = true
            noInfolabel.isHidden = false
            noInfolabel.text = self.noInfo
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
