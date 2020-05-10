//
//  BreedDetailsViewController.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 05.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit
import SafariServices

class BreedDetailsViewController: UIViewController {

    //MARK: Outlets
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
    
    
    //MARK: - Properties
    let networkManager = NetworkManager()
    let emojiManager = EmojiManager()
    
    var breedID: String = ""
    var breedDetails: [BreedDetails] = []
    let noInfo = "No information available"
    
    //MARK: - ViewController life cycle
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
    
    //MARK: - UI updating
    func updateUI(details: [BreedDetails]) {
        if let imageURL = details.first?.url {
            networkManager.getImage(imageURL: imageURL) { (image) in
                DispatchQueue.main.async {
                    self.catsImage.image = image
                    if let breed: Breed = self.breedDetails.first?.breeds.first {
                        self.breedName.text = breed.name
//                        self.navigationItem.title = breed.name
                        
                        //Description
                        self.valueDescription.text = breed.description
                        
                        //Temperament
                        self.valueTemperament.text = breed.temperament
                        
                        //Origin
                        self.valueOrigin.text = "\(breed.origin ?? self.noInfo) \(self.emojiManager.emojiFlag(regionCode: breed.countryCode ?? "") ?? "")"
                        
                        //Life Span
                        self.valueLifeSpan.text = {
                            if let lifeSpan = breed.lifeSpan {
                                return "\(lifeSpan) years"
                            } else {
                                return self.noInfo
                            }
                        }()
                        
                        //Weight
                        self.valueWeightLabel.text = "\(breed.weight.metric ?? self.noInfo) kg  (\(breed.weight.imperial ?? "") lb)"
                        
                        
                        //Adaptability
                        self.setValueToProgressView(value: breed.adaptability,
                                                    progressView: self.valueAdaptabilityProgress,
                                                    noInfolabel: self.valueAdaptabilityLabel,
                                                    zeroFiveLabelsNumber: 0)
                        
                        //Affection level
                        self.setValueToProgressView(value: breed.affectionLevel,
                                                    progressView: self.valueAffectionProgress,
                                                    noInfolabel: self.valueAffectionLabel,
                                                    zeroFiveLabelsNumber: 1)
                        
                        //Cat friendly
                        self.setValueToProgressView(value: breed.catFriendly,
                                                    progressView: self.valueCatFriendlyProgress,
                                                    noInfolabel: self.valueCatFriendlyLabel,
                                                    zeroFiveLabelsNumber: 2)
                        //Child friendly
                        self.setValueToProgressView(value: breed.childFriendly,
                                                    progressView: self.valueChildFriendlyProgress,
                                                    noInfolabel: self.valueChildFriendlyLabel,
                                                    zeroFiveLabelsNumber: 3)
                        //Dog friendly
                        self.setValueToProgressView(value: breed.dogFriendly,
                                                    progressView: self.valueDogFriendlyProgress,
                                                    noInfolabel: self.valueDogFriendlyLabel,
                                                    zeroFiveLabelsNumber: 4)
                        //Energy level
                        self.setValueToProgressView(value: breed.energyLevel,
                                                    progressView: self.valueEnergyLevelProgress,
                                                    noInfolabel: self.valueEnergyLevelLabel,
                                                    zeroFiveLabelsNumber: 5)
                        //Grooming
                        self.setValueToProgressView(value: breed.grooming,
                                                    progressView: self.valueGroomingProgress,
                                                    noInfolabel: self.valueGroomingLabel,
                                                    zeroFiveLabelsNumber: 6)
                        
                        //Health issues
                        self.setValueToProgressView(value: breed.healthIssues,
                                                    progressView: self.valuehealthIssuesProgress,
                                                    noInfolabel: self.valuehealthIssuesLabel,
                                                    zeroFiveLabelsNumber: 7)
                        
                        //Intelligence
                        self.setValueToProgressView(value: breed.intelligence,
                                                    progressView: self.valueIntelligenceProgress,
                                                    noInfolabel: self.valueIntelligenceLabel,
                                                    zeroFiveLabelsNumber: 8)
                        //Shedding level
                        self.setValueToProgressView(value: breed.sheddingLevel,
                                                    progressView: self.valueSheddingLevelProgress,
                                                    noInfolabel: self.valueSheddingLevelLabel,
                                                    zeroFiveLabelsNumber: 9)
                        //Social needs
                        self.setValueToProgressView(value: breed.socialNeeds,
                                                    progressView: self.valueSocialNeedsProgress,
                                                    noInfolabel: self.valueSocialNeedsLabel,
                                                    zeroFiveLabelsNumber: 10)
                        
                        //Stranger friendly
                        self.setValueToProgressView(value: breed.strangerFriendly,
                                                    progressView: self.valueStrangerFriendlyProgress,
                                                    noInfolabel: self.valueStrangerFriendlyLabel,
                                                    zeroFiveLabelsNumber: 11)
                        
                        //Vocalisation
                        self.setValueToProgressView(value: breed.vocalisation,
                                                    progressView: self.valueVocalisationProgress,
                                                    noInfolabel: self.valueVocalisationLabel,
                                                    zeroFiveLabelsNumber: 12)
                        
                        //Indor
                        self.valueIndor.text = self.binaryToYesNo(number: breed.indoor)
                        
                        //Experimental
                        self.valueExperimentalLabel.text = self.binaryToYesNo(number: breed.experimental)
                        
                        //Hairless
                        self.valueHairlessLabel.text = self.binaryToYesNo(number: breed.experimental)
                        
                        //Rare
                        self.valueRareLabel.text = self.binaryToYesNo(number: breed.rare)
                        
                        //Rex
                        self.valueRexLabel.text = self.binaryToYesNo(number: breed.rex)
                        
                        //Suppressed tail
                        self.valueSuppressedTailLabel.text = self.binaryToYesNo(number: breed.suppressedTail)
                        
                        //Short legs
                        self.valueShortLegsLabel.text = self.binaryToYesNo(number: breed.shortLegs)
                        
                        //
                        self.valueHypoallergenicLabel.text = self.binaryToYesNo(number: breed.hypoallergenic)
                    }
                }
            }
        }
    }
    
    
    //MARK: - Support func for UI update
    
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
            return (0.0, UIColor.systemYellow)
        case 1:
            return (0.2, UIColor.systemYellow)
        case 2:
            return (0.4, UIColor.systemOrange)
        case 3:
            return (0.6, UIColor.systemOrange)
        case 4:
            return (0.8, UIColor.systemRed)
        default:
            return (1.0, UIColor.systemRed)
        }
    }
    
    
    // set value to progress view if value is not nil. If it is nil, function hide progressView, labels 0 and 5 and displays no info label
    func setValueToProgressView(value: Int?, progressView: UIProgressView, noInfolabel: UILabel, zeroFiveLabelsNumber: Int) {
        if let value = value {
            let progressLevel = intToProgressLevel(level: value)
            progressView.setProgress(progressLevel.level, animated: false)
//            progressView.tintColor = progressLevel.color
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
//MARK: - Extension
extension BreedDetailsViewController {
    
    
    //MARK: Get another Image
    //load and display new  breed image on tap
    @IBAction func imageTapped(_ gestureRecignizer: UITapGestureRecognizer) {
        guard gestureRecignizer.view != nil else {
            return
        }
        
        if gestureRecignizer.state == .ended {
            networkManager.getBreedDetails(breedID: breedID) { (breedDetails) in
                self.networkManager.getImage(imageURL: breedDetails.first!.url) { (newImage) in
                    self.imageChangingAnimation(newImage: newImage)
                }
            }
        }
        tapToChangeLabel.textColor = .clear
    }
    
    //animate changing of the cat image
    func imageChangingAnimation(newImage: UIImage) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: {
                self.catsImage.alpha = 0
            }) {_ in
                self.catsImage.image = newImage
                UIView.animate(withDuration: 0.4) {
                    self.catsImage.alpha = 1
                }
            }
        }
    }
    
    //MARK: Safari View Controller
    //Present links in Safari ViewController
    func presentSafariVCForUrl(urlString: String?, sender: UIButton) {
        guard let cfaURLString = urlString else {
            sender.isEnabled = false
            return
        }
        if let url = URL(string: cfaURLString) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
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
