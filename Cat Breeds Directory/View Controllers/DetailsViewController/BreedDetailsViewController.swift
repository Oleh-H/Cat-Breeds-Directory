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
    
    @IBOutlet weak var adaptabilityStack: UIStackView!
    @IBOutlet weak var affectionStack: UIStackView!
    @IBOutlet weak var catFriendlyStack: UIStackView!
    @IBOutlet weak var childFriendlyStack: UIStackView!
    @IBOutlet weak var dogFriendlyStack: UIStackView!
    @IBOutlet weak var energyLevelStack: UIStackView!
    @IBOutlet weak var groomingStack: UIStackView!
    @IBOutlet weak var healthIssuesStack: UIStackView!
    @IBOutlet weak var inteligenceStack: UIStackView!
    @IBOutlet weak var sheddingLevelStack: UIStackView!
    @IBOutlet weak var socialNeedsStack: UIStackView!
    @IBOutlet weak var strangerFriendlyStack: UIStackView!
    @IBOutlet weak var vocalisationStack: UIStackView!
    
    
    @IBOutlet weak var valueExperimentalLabel: UILabel!
    @IBOutlet weak var valueHairlessLabel: UILabel!
    @IBOutlet weak var valueRareLabel: UILabel!
    @IBOutlet weak var valueRexLabel: UILabel!
    @IBOutlet weak var valueSuppressedTailLabel: UILabel!
    @IBOutlet weak var valueShortLegsLabel: UILabel!
    @IBOutlet weak var valueHypoallergenicLabel: UILabel!
    
    @IBOutlet weak var uiCoverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorImage: UIActivityIndicatorView!
    
    @IBOutlet weak var cfaButton: UIButton!
    @IBOutlet weak var vcaHospitalsButton: UIButton!
    @IBOutlet weak var vetstreetButton: UIButton!
    @IBOutlet weak var wikipediaButton: UIButton!
    
    
    //MARK: - Properties
    let emojiManager = EmojiManager()
    let model = BreedDetailsModel()
    
    var breedID: String = ""
    var breedDetails: [BreedDetails] = []
    var breed: Breed?
    
    
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
        model.getBreedDetails(breedID: breedID) { [weak self] details in
            self?.breedDetails = details
            self?.breed = details.first?.breeds.first
            self?.updateUI(details: details)
        }
    }
    
    //MARK: - UI updating
    func updateUI(details: [BreedDetails]) {
        if let imageURL = details.first?.url {
            model.getImage(imageURL: imageURL) { (image) in
                DispatchQueue.main.async {
                    self.catsImage.image = image
                    self.setValuesForValueLabels()
                }
            }
        }
    }
    
    
    //MARK: - Fill Values
    
    func setValuesForValueLabels() {
        guard let breed = breed else {return}
        
        breedName.text = breed.name
        
        //Description
        valueDescription.text = breed.description
        
        //Temperament
        valueTemperament.text = breed.temperament
        
        //Origin
        valueOrigin.text = "\(breed.origin ?? model.noInfoString) \(emojiManager.emojiFlag(regionCode: breed.countryCode ?? "") ?? "")"
        
        //Life Span
        valueLifeSpan.text = {
            if let lifeSpan = breed.lifeSpan {
                return "\(lifeSpan) years"
            } else {
                return model.noInfoString
            }
        }()
        
        //Weight
        valueWeightLabel.text = "\(breed.weight.metric ?? model.noInfoString) kg  (\(breed.weight.imperial ?? "") lb)"
        
        //Adaptability
        let adaptability = model.displayVauesFom1To5(value: breed.adaptability)
        adaptabilityStack.addArrangedSubview(adaptability)
        
        //Affection level
        let affection = model.displayVauesFom1To5(value: breed.affectionLevel)
        affectionStack.addArrangedSubview(affection)
        
        //Cat friendly
        let catFriendly = model.displayVauesFom1To5(value: breed.catFriendly)
        catFriendlyStack.addArrangedSubview(catFriendly)

        //Child friendly
        let childFriendly = model.displayVauesFom1To5(value: breed.childFriendly)
        childFriendlyStack.addArrangedSubview(childFriendly)

        //Dog friendly
        let dogFriendly = model.displayVauesFom1To5(value: breed.dogFriendly)
        dogFriendlyStack.addArrangedSubview(dogFriendly)

        //Energy level
        let energyLevel = model.displayVauesFom1To5(value: breed.energyLevel)
        energyLevelStack.addArrangedSubview(energyLevel)

        //Grooming
        let groomong = model.displayVauesFom1To5(value: breed.grooming)
        groomingStack.addArrangedSubview(groomong)
        
        //Health issues
        let healthIssues = model.displayVauesFom1To5(value: breed.grooming)
        healthIssuesStack.addArrangedSubview(healthIssues)
        
        //Intelligence
        let inteligence = model.displayVauesFom1To5(value: breed.intelligence)
        inteligenceStack.addArrangedSubview(inteligence)

        //Shedding level
        let sheddingLevel = model.displayVauesFom1To5(value: breed.sheddingLevel)
        sheddingLevelStack.addArrangedSubview(sheddingLevel)

        //Social needs
        let socialNeeds = model.displayVauesFom1To5(value: breed.socialNeeds)
        socialNeedsStack.addArrangedSubview(socialNeeds)
        
        //Stranger friendly
        let straingerFriendly = model.displayVauesFom1To5(value: breed.strangerFriendly)
        strangerFriendlyStack.addArrangedSubview(straingerFriendly)
        
        //Vocalisation
        let vocalisation = model.displayVauesFom1To5(value: breed.vocalisation)
        vocalisationStack.addArrangedSubview(vocalisation)
        
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
        
        cfaButton.isEnabled = model.ifStringIsNotNil(string: breed.cfaURL)
        
        vcaHospitalsButton.isEnabled = model.ifStringIsNotNil(string: breed.vcahospitalsURL)
        
        vetstreetButton.isEnabled = model.ifStringIsNotNil(string: breed.vetstreetURL)
        
        wikipediaButton.isEnabled = model.ifStringIsNotNil(string: breed.wikipediaURL)
        
        shareBarButton.isEnabled = true
        activityIndicator.stopAnimating()
        uiCoverView.removeFromSuperview()
    }
    
    
    @IBAction func cfaURLTap(_ sender: UIButton) {
        presentSafariVC(urlString: breed?.cfaURL)
    }
    
    @IBAction func vcaHospitalsTap(_ sender: UIButton) {
        presentSafariVC(urlString: breed?.vcahospitalsURL)
    }
    
    @IBAction func vetStreetTap(_ sender: UIButton) {
        presentSafariVC(urlString: breed?.vetstreetURL)
    }
    
    @IBAction func wikipediaTap(_ sender: UIButton) {
        presentSafariVC(urlString: breed?.wikipediaURL)
    }
}
