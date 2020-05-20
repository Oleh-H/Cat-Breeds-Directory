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
    let network = BreedDetailsNetwork()
    //let progressDisplayingStackView = ProgressDisplayingStackView()
    
    var breedID: String = ""
    var breedDetails: [BreedDetails] = []
    var breed: Breed?
    var links: [String?] = []
    
    
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
        model.preparedDataForUI(breedID: breedID) { result in
            switch result {
            case .success(let texts, let stackViews, let yesNoLabels, let links, let image):
                self.links = links
                DispatchQueue.main.async {
                    self.setTexts(texts: texts)
                    self.setValuesForStacks(stack: stackViews)
                    self.setValuesForYesNoLabels(yesNoLabels: yesNoLabels)
                    self.checkLinksForButtons(links: links)
                    self.catsImage.image = image
                    
                    self.shareBarButton.isEnabled = true
                    self.activityIndicator.stopAnimating()
                    self.uiCoverView.removeFromSuperview()
                }
            case .failure(let error):
                self.presentAlert(error: error, isItForDetailsData: true)
            }
        }
    }

    
    //MARK: Error Alert
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
    
    func setTexts(texts: [String: String]) {
        breedName.text = texts["name"]
        valueTemperament.text = texts["temperament"]
        valueOrigin.text = texts["origin"]
        valueDescription.text = texts["description"]
        valueLifeSpan.text = texts["lifeSpan"]
        valueWeightLabel.text = texts["weight"]
    }

    
    func setValuesForStacks(stack: [String: UIStackView]) {
        
        let stackViewsForProgressView = [adaptabilityStack, affectionStack, catFriendlyStack, childFriendlyStack, dogFriendlyStack, energyLevelStack, groomingStack, healthIssuesStack, inteligenceStack, sheddingLevelStack, socialNeedsStack, strangerFriendlyStack, vocalisationStack]
        
        for (index, emptyStack) in stackViewsForProgressView.enumerated() {
            let preparedStack = stack[Constants.valueNamesForStackViews[index]]
            emptyStack?.addArrangedSubview(preparedStack!)
        }
    }
    
    
    func setValuesForYesNoLabels(yesNoLabels: [String: String]) {
        let labels = [valueIndor, valueExperimentalLabel, valueHairlessLabel, valueRareLabel, valueRexLabel, valueSuppressedTailLabel, valueShortLegsLabel, valueHypoallergenicLabel]
                
        for (index, label) in labels.enumerated() {
            let name = Constants.valueNamesForYesNoLabels[index]
            let value = yesNoLabels[name]
            label?.text = value
        }
    }
    
    func checkLinksForButtons(links: [String?]) {
        let buttons = [cfaButton, vcaHospitalsButton, vetstreetButton, wikipediaButton]
        
        for (index, button) in buttons.enumerated() {
            guard links[index] != nil && links[index] != "" else { continue }
            button?.isEnabled = true
        }
    }
    
    
    @IBAction func cfaURLTap(_ sender: UIButton) {
        let safariVC = links[0]?.urlToSafariViewController()
        present(safariVC!, animated: true, completion: nil)
    }
    
    @IBAction func vcaHospitalsTap(_ sender: UIButton) {
        let safariVC = links[1]?.urlToSafariViewController()
        present(safariVC!, animated: true, completion: nil)
    }
    
    @IBAction func vetStreetTap(_ sender: UIButton) {
        let safariVC = links[2]?.urlToSafariViewController()
        present(safariVC!, animated: true, completion: nil)
    }
    
    @IBAction func wikipediaTap(_ sender: UIButton) {
        let safariVC = links[3]?.urlToSafariViewController()
        present(safariVC!, animated: true, completion: nil)
    }
}
