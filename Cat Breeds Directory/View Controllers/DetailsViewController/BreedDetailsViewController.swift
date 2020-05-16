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
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var tapToChangeLabel: UILabel!
    
    @IBOutlet weak var catsImage: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    
    @IBOutlet weak var valueTemperament: UILabel!
    
    @IBOutlet weak var valueOrigin: UILabel!
    
    @IBOutlet weak var valueDescription: UILabel!
    
    @IBOutlet weak var valueLifeSpan: UILabel!
    
    @IBOutlet weak var valueWeightLabel: UILabel!
    
    @IBOutlet weak var valueIndor: UILabel!
    
    @IBOutlet weak var valueAdaptabilityProgress: UIProgressView!
    @IBOutlet weak var valueAdaptabilityLabel: UILabel!
    
    @IBOutlet weak var valueAffectionProgress: UIProgressView!
    @IBOutlet weak var valueAffectionLabel: UILabel!
    
    @IBOutlet weak var valueCatFriendlyProgress: UIProgressView!
    @IBOutlet weak var valueCatFriendlyLabel: UILabel!
    
    @IBOutlet weak var valueChildFriendlyProgress: UIProgressView!
    @IBOutlet weak var valueChildFriendlyLabel: UILabel!
    
    @IBOutlet weak var valueDogFriendlyProgress: UIProgressView!
    @IBOutlet weak var valueDogFriendlyLabel: UILabel!
    
    @IBOutlet weak var valueEnergyLevelProgress: UIProgressView!
    @IBOutlet weak var valueEnergyLevelLabel: UILabel!
    
    @IBOutlet weak var valueGroomingProgress: UIProgressView!
    @IBOutlet weak var valueGroomingLabel: UILabel!
    
    @IBOutlet weak var valuehealthIssuesProgress: UIProgressView!
    @IBOutlet weak var valuehealthIssuesLabel: UILabel!
    
    @IBOutlet weak var valueIntelligenceProgress: UIProgressView!
    @IBOutlet weak var valueIntelligenceLabel: UILabel!
    
    @IBOutlet weak var valueSheddingLevelProgress: UIProgressView!
    @IBOutlet weak var valueSheddingLevelLabel: UILabel!
    
    @IBOutlet weak var valueSocialNeedsProgress: UIProgressView!
    @IBOutlet weak var valueSocialNeedsLabel: UILabel!
    
    @IBOutlet weak var valueStrangerFriendlyProgress: UIProgressView!
    @IBOutlet weak var valueStrangerFriendlyLabel: UILabel!
    
    @IBOutlet weak var valueVocalisationProgress: UIProgressView!
    @IBOutlet weak var valueVocalisationLabel: UILabel!
    
    @IBOutlet weak var valueExperimentalLabel: UILabel!
    
    @IBOutlet weak var valueHairlessLabel: UILabel!
    
    @IBOutlet weak var valueRareLabel: UILabel!
    
    @IBOutlet weak var valueRexLabel: UILabel!
    
    @IBOutlet weak var valueSuppressedTailLabel: UILabel!
    
    @IBOutlet weak var valueShortLegsLabel: UILabel!
    
    @IBOutlet weak var valueHypoallergenicLabel: UILabel!
    
    @IBOutlet var zeroLabel: [UILabel]!
    @IBOutlet var fiveLabel: [UILabel]!
    
    
    @IBOutlet weak var uiCoverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorImage: UIActivityIndicatorView!
    
    //MARK: - Properties
    let networkManager = NetworkManager()
    let emojiManager = EmojiManager()
    
    var breedID: String = ""
    var breedDetails: [BreedDetails] = []
    let noInfo = "No information available"
    
    //MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicatorImage.hidesWhenStopped = true
        activityIndicatorImage.isHidden = true
        
        shareBarButton.isEnabled = false
        
        catsImage.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        catsImage.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        catsImage.layer.shadowRadius = CGFloat(5.0)
        catsImage.layer.shadowOpacity = 1.0
        catsImage.layer.masksToBounds = false
        
        activityIndicator.startAnimating()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        networkManager.getBreedDetails(breedID: breedID) { [weak self] details in            
            self?.breedDetails = details
            self?.updateUI(details: details)
        }
    }
    
    //MARK: - UI updating
    func updateUI(details: [BreedDetails]) {
        if let imageURL = details.first?.url {
            networkManager.getImage(imageURL: imageURL) { (image) in
                DispatchQueue.main.async {
                    self.catsImage.image = image
                    self.setValuesForValueLabels()
                }
            }
        }
    }
    
    
    //MARK: - Fill Values
    
    func setValuesForValueLabels() {
        guard let breed: Breed = breedDetails.first?.breeds.first else {return}
        
        breedName.text = breed.name
        
        //Description
        valueDescription.text = breed.description
        
        //Temperament
        valueTemperament.text = breed.temperament
        
        //Origin
        valueOrigin.text = "\(breed.origin ?? noInfo) \(emojiManager.emojiFlag(regionCode: breed.countryCode ?? "") ?? "")"
        
        //Life Span
        valueLifeSpan.text = {
            if let lifeSpan = breed.lifeSpan {
                return "\(lifeSpan) years"
            } else {
                return noInfo
            }
        }()
        
        //Weight
        valueWeightLabel.text = "\(breed.weight.metric ?? noInfo) kg  (\(breed.weight.imperial ?? "") lb)"
        
        
        //Adaptability
        setValueToProgressView(value: breed.adaptability,
                                    progressView: valueAdaptabilityProgress,
                                    noInfolabel: valueAdaptabilityLabel,
                                    zeroFiveLabelsNumber: 0)
        
        //Affection level
        setValueToProgressView(value: breed.affectionLevel,
                                    progressView: valueAffectionProgress,
                                    noInfolabel: valueAffectionLabel,
                                    zeroFiveLabelsNumber: 1)
        
        //Cat friendly
        setValueToProgressView(value: breed.catFriendly,
                                    progressView: valueCatFriendlyProgress,
                                    noInfolabel: valueCatFriendlyLabel,
                                    zeroFiveLabelsNumber: 2)
        //Child friendly
        setValueToProgressView(value: breed.childFriendly,
                                    progressView: valueChildFriendlyProgress,
                                    noInfolabel: valueChildFriendlyLabel,
                                    zeroFiveLabelsNumber: 3)
        //Dog friendly
        setValueToProgressView(value: breed.dogFriendly,
                                    progressView: valueDogFriendlyProgress,
                                    noInfolabel: valueDogFriendlyLabel,
                                    zeroFiveLabelsNumber: 4)
        //Energy level
        setValueToProgressView(value: breed.energyLevel,
                                    progressView: valueEnergyLevelProgress,
                                    noInfolabel: valueEnergyLevelLabel,
                                    zeroFiveLabelsNumber: 5)
        //Grooming
        setValueToProgressView(value: breed.grooming,
                                    progressView: valueGroomingProgress,
                                    noInfolabel: valueGroomingLabel,
                                    zeroFiveLabelsNumber: 6)
        
        //Health issues
        setValueToProgressView(value: breed.healthIssues,
                                    progressView: valuehealthIssuesProgress,
                                    noInfolabel: valuehealthIssuesLabel,
                                    zeroFiveLabelsNumber: 7)
        
        //Intelligence
        setValueToProgressView(value: breed.intelligence,
                                    progressView: valueIntelligenceProgress,
                                    noInfolabel: valueIntelligenceLabel,
                                    zeroFiveLabelsNumber: 8)
        //Shedding level
        setValueToProgressView(value: breed.sheddingLevel,
                                    progressView: valueSheddingLevelProgress,
                                    noInfolabel: valueSheddingLevelLabel,
                                    zeroFiveLabelsNumber: 9)
        //Social needs
        setValueToProgressView(value: breed.socialNeeds,
                                    progressView: valueSocialNeedsProgress,
                                    noInfolabel: valueSocialNeedsLabel,
                                    zeroFiveLabelsNumber: 10)
        
        //Stranger friendly
        setValueToProgressView(value: breed.strangerFriendly,
                                    progressView: valueStrangerFriendlyProgress,
                                    noInfolabel: valueStrangerFriendlyLabel,
                                    zeroFiveLabelsNumber: 11)
        
        //Vocalisation
        setValueToProgressView(value: breed.vocalisation,
                                    progressView: valueVocalisationProgress,
                                    noInfolabel: valueVocalisationLabel,
                                    zeroFiveLabelsNumber: 12)
        
        //Indor
        valueIndor.text = StringBinar(binarInt: breed.indoor).value
        
        //Experimental
        valueExperimentalLabel.text = StringBinar(binarInt: breed.experimental).value
        
        //Hairless
        valueHairlessLabel.text = StringBinar(binarInt: breed.hairless).value
        
        //Rare
        valueRareLabel.text = StringBinar(binarInt: breed.rare).value
        
        //Rex
        valueRexLabel.text = StringBinar(binarInt: breed.rex).value
        
        //Suppressed tail
        valueSuppressedTailLabel.text = StringBinar(binarInt: breed.suppressedTail).value
        
        //Short legs
        valueShortLegsLabel.text = StringBinar(binarInt: breed.shortLegs).value
        
        //
        valueHypoallergenicLabel.text = StringBinar(binarInt: breed.hypoallergenic).value
        
        shareBarButton.isEnabled = true
        activityIndicator.stopAnimating()
        uiCoverView.removeFromSuperview()
    }
    
    
    @IBAction func cfaURLTap(_ sender: UIButton) {
        presentSafariVCForUrl(urlString: breedDetails.first?.breeds.first?.cfaURL, sender: sender)
    }
    
    @IBAction func vcaHospitalsTap(_ sender: UIButton) {
        presentSafariVCForUrl(urlString: breedDetails.first?.breeds.first?.vcahospitalsURL, sender: sender)
    }
    
    @IBAction func vetStreetTap(_ sender: UIButton) {
        presentSafariVCForUrl(urlString: breedDetails.first?.breeds.first?.vetstreetURL, sender: sender)
    }
    
    @IBAction func wikipediaTap(_ sender: UIButton) {
        presentSafariVCForUrl(urlString: breedDetails.first?.breeds.first?.wikipediaURL, sender: sender)
    }
}
