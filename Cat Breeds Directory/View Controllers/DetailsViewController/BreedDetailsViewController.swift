//
//  BreedDetailsViewController.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 05.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class BreedDetailsViewController: UIViewController, Storyboarded {

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
    @IBOutlet weak var activityIndicatorForImage: UIActivityIndicatorView!
    
    @IBOutlet weak var cfaButton: UIButton!
    @IBOutlet weak var vcaHospitalsButton: UIButton!
    @IBOutlet weak var vetstreetButton: UIButton!
    @IBOutlet weak var wikipediaButton: UIButton!
    
    
    //MARK: - Properties
    weak var mainCoordinator: MainCoordinator?
    let emojiManager = EmojiManager()
    let model = BreedDetailsModel()
    let progressDisplayingStackView = ProgressDisplayingStackView()
    
    var breedID: String = ""
    var breedDetails: [BreedDetails] = []
    var breed: Breed?
    
    
    //MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicatorForImage.hidesWhenStopped = true
        activityIndicatorForImage.isHidden = true
        
        shareBarButton.isEnabled = false
        
        catsImage.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        catsImage.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        catsImage.layer.shadowRadius = CGFloat(5.0)
        catsImage.layer.shadowOpacity = 1.0
        catsImage.layer.masksToBounds = false
        
        activityIndicator.startAnimating()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        loadData()
    }
    
    //MARK: - Data loading and error handling
    func loadData() {
        model.getBreedDetails(breedID: breedID) { [weak self] details in
            switch details {
            case .success(let details):
                self?.breedDetails = details
                self?.breed = details.first?.breeds.first
                self?.updateUI(details: details)
            case .failure(let error):
                self?.presentAlert(error: error, isItForDetailsData: true)
            }
        }
    }
    
    func presentAlert(error: Error, isItForDetailsData: Bool) {
        let alert = UIAlertController.init(title: Constants.errorAlertTitle, message: error.localizedDescription, preferredStyle: .alert)
        if isItForDetailsData {
            alert.addAction(UIAlertAction(title: Constants.errorAlertButton, style: .default, handler: { _ in
                self.loadData()
            }))
        } else {
            alert.addAction(UIAlertAction(title: Constants.errorAlertButton, style: .default, handler: { _ in
                self.changeImage()
            }))
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    //MARK: - UI updating
    func updateUI(details: [BreedDetails]) {
        if let imageURL = details.first?.url {
            model.getImage(imageURL: imageURL) { (image) in
                switch image {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.catsImage.image = image
                        self.setValuesForValueLabels()
                    }
                case .failure(let error):
                    self.presentAlert(error: error, isItForDetailsData: true)
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
        valueOrigin.text = "\(breed.origin ?? Constants.noInfoString) \(emojiManager.emojiFlag(regionCode: breed.countryCode ?? "") ?? "")"
        
        //Life Span
        valueLifeSpan.text = {
            if let lifeSpan = breed.lifeSpan {
                return "\(lifeSpan) years"
            } else {
                return Constants.noInfoString
            }
        }()
        
        //Weight
        valueWeightLabel.text = "\(breed.weight.metric ?? Constants.noInfoString) kg  (\(breed.weight.imperial ?? "") lb)"
        
        //Adaptability
        let adaptability = progressDisplayingStackView.displayVauesFom1To5(value: breed.adaptability)
        adaptabilityStack.addArrangedSubview(adaptability)
        
        //Affection level
        let affection = progressDisplayingStackView.displayVauesFom1To5(value: breed.affectionLevel)
        affectionStack.addArrangedSubview(affection)
        
        //Cat friendly
        let catFriendly = progressDisplayingStackView.displayVauesFom1To5(value: breed.catFriendly)
        catFriendlyStack.addArrangedSubview(catFriendly)

        //Child friendly
        let childFriendly = progressDisplayingStackView.displayVauesFom1To5(value: breed.childFriendly)
        childFriendlyStack.addArrangedSubview(childFriendly)

        //Dog friendly
        let dogFriendly = progressDisplayingStackView.displayVauesFom1To5(value: breed.dogFriendly)
        dogFriendlyStack.addArrangedSubview(dogFriendly)

        //Energy level
        let energyLevel = progressDisplayingStackView.displayVauesFom1To5(value: breed.energyLevel)
        energyLevelStack.addArrangedSubview(energyLevel)

        //Grooming
        let groomong = progressDisplayingStackView.displayVauesFom1To5(value: breed.grooming)
        groomingStack.addArrangedSubview(groomong)
        
        //Health issues
        let healthIssues = progressDisplayingStackView.displayVauesFom1To5(value: breed.healthIssues)
        healthIssuesStack.addArrangedSubview(healthIssues)
        
        //Intelligence
        let inteligence = progressDisplayingStackView.displayVauesFom1To5(value: breed.intelligence)
        inteligenceStack.addArrangedSubview(inteligence)

        //Shedding level
        let sheddingLevel = progressDisplayingStackView.displayVauesFom1To5(value: breed.sheddingLevel)
        sheddingLevelStack.addArrangedSubview(sheddingLevel)

        //Social needs
        let socialNeeds = progressDisplayingStackView.displayVauesFom1To5(value: breed.socialNeeds)
        socialNeedsStack.addArrangedSubview(socialNeeds)
        
        //Stranger friendly
        let straingerFriendly = progressDisplayingStackView.displayVauesFom1To5(value: breed.strangerFriendly)
        strangerFriendlyStack.addArrangedSubview(straingerFriendly)
        
        //Vocalisation
        let vocalisation = progressDisplayingStackView.displayVauesFom1To5(value: breed.vocalisation)
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
        let safariVC = breed?.cfaURL?.urlToSafariViewController()
        present(safariVC!, animated: true, completion: nil)
    }
    
    @IBAction func vcaHospitalsTap(_ sender: UIButton) {
        let safariVC = breed?.vcahospitalsURL?.urlToSafariViewController()
        present(safariVC!, animated: true, completion: nil)
    }
    
    @IBAction func vetStreetTap(_ sender: UIButton) {
        let safariVC = breed?.vetstreetURL?.urlToSafariViewController()
        present(safariVC!, animated: true, completion: nil)
    }
    
    @IBAction func wikipediaTap(_ sender: UIButton) {
        let safariVC = breed?.wikipediaURL?.urlToSafariViewController()
        present(safariVC!, animated: true, completion: nil)
    }
}
