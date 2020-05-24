//
//  BreedDetailsViewController.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 05.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit
///Displays breed's cat image and detailed description with links to external resources.
class BreedDetailsViewController: UIViewController, Storyboarded {

    //MARK: Outlets
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var tapToChangeLabel: UILabel!
    //MARK: Image and Name
    @IBOutlet weak var catsImage: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    //MARK: Labels with text
    @IBOutlet weak var valueTemperament: UILabel!
    @IBOutlet weak var valueOrigin: UILabel!
    @IBOutlet weak var valueDescription: UILabel!
    @IBOutlet weak var valueLifeSpan: UILabel!
    @IBOutlet weak var valueWeightLabel: UILabel!
    @IBOutlet weak var valueIndor: UILabel!
    //MARK: StackViews with ProgressView
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
    //MARK: Labels with Yes / NO
    @IBOutlet weak var valueExperimentalLabel: UILabel!
    @IBOutlet weak var valueHairlessLabel: UILabel!
    @IBOutlet weak var valueRareLabel: UILabel!
    @IBOutlet weak var valueRexLabel: UILabel!
    @IBOutlet weak var valueSuppressedTailLabel: UILabel!
    @IBOutlet weak var valueShortLegsLabel: UILabel!
    @IBOutlet weak var valueHypoallergenicLabel: UILabel!
    //MARK: Link buttons
    @IBOutlet weak var cfaButton: UIButton!
    @IBOutlet weak var vcaHospitalsButton: UIButton!
    @IBOutlet weak var vetstreetButton: UIButton!
    @IBOutlet weak var wikipediaButton: UIButton!
    
    @IBOutlet weak var uiCoverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorForImage: UIActivityIndicatorView!
    
    
    //MARK: - Properties
    weak var mainCoordinator: MainCoordinator?
    let emojiManager = EmojiManager()
    let model = BreedDetailsModel()
    let network = BreedDetailsNetwork()
    
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
        
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        activityIndicator.startAnimating()
        loadData()
    }
    
    
    //MARK: - Data loading and error handling
    ///Get data from model and Updates the UI.
    func loadData() {
        model.preparedDataForUI(breedID: breedID) { result in
            switch result {
            case .success(let tupple):
                let(texts, stackViews, yesNoLabels, links, image) = tupple
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
    ///Present error alert with `Reload` button
    ///
    ///Present alert with localized error description and button that run data loading again in case its data for the whole page.
    ///Or, display error for the loading cat image and reloading button respectively for it.
    func presentAlert(error: Error, isItForDetailsData: Bool) {
        let alert = UIAlertController.init(title: Strings.errorAlertTitle, message: error.localizedDescription, preferredStyle: .alert)
        if isItForDetailsData {
            alert.addAction(UIAlertAction(title: Strings.errorAlertButton, style: .default, handler: { _ in
                self.loadData()
            }))
        } else {
            alert.addAction(UIAlertAction(title: Strings.errorAlertButton, style: .default, handler: { _ in
                self.changeCatImage()
            }))
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    //MARK: - UI updating
    ///Set strings to the determined in the function UILabels.
    func setTexts(texts: [String: String]) {
        breedName.text = texts["name"]
        valueTemperament.text = texts["temperament"]
        valueOrigin.text = texts["origin"]
        valueDescription.text = texts["description"]
        valueLifeSpan.text = texts["lifeSpan"]
        valueWeightLabel.text = texts["weight"]
    }

    ///Append (prepared and transfered into the function) stackViews into determined in the function UIStackWiews.
    func setValuesForStacks(stack: [String: UIStackView]) {
        let stackViewsForProgressView = [adaptabilityStack, affectionStack, catFriendlyStack, childFriendlyStack, dogFriendlyStack, energyLevelStack, groomingStack, healthIssuesStack, inteligenceStack, sheddingLevelStack, socialNeedsStack, strangerFriendlyStack, vocalisationStack]
        
        for (index, emptyStack) in stackViewsForProgressView.enumerated() {
            let preparedStack = stack[Constants.valueNamesForStackViews[index]]
            emptyStack?.addArrangedSubview(preparedStack!)
        }
    }
    
    ///Set strings to the determined in the function UILabels.
    func setValuesForYesNoLabels(yesNoLabels: [String: String]) {
        let labels = [valueIndor, valueExperimentalLabel, valueHairlessLabel, valueRareLabel, valueRexLabel, valueSuppressedTailLabel, valueShortLegsLabel, valueHypoallergenicLabel]
                
        for (index, label) in labels.enumerated() {
            let name = Constants.valueNamesForYesNoLabels[index]
            let value = yesNoLabels[name]
            label?.text = value
        }
    }
    ///Set button Enabled / Disabled depending of existing the URL for the button.
    ///
    ///Button will left disabled if string contains `nil` or empty string.
    func checkLinksForButtons(links: [String?]) {
        let buttons = [cfaButton, vcaHospitalsButton, vetstreetButton, wikipediaButton]
        
        for (index, button) in buttons.enumerated() {
            guard links[index] != nil && links[index] != "" else { continue }
            button?.isEnabled = true
        }
    }
    
    //MARK: - Buttons actions
    @IBAction func cfaURLTap(_ sender: UIButton) {
        presentSafariViewController(link: links[0])
    }
    
    @IBAction func vcaHospitalsTap(_ sender: UIButton) {
        presentSafariViewController(link: links[1])
    }
    
    @IBAction func vetStreetTap(_ sender: UIButton) {
        presentSafariViewController(link: links[2])
    }
    
    @IBAction func wikipediaTap(_ sender: UIButton) {
        presentSafariViewController(link: links[3])
    }
    
    func presentSafariViewController(link: String?) {
        guard let safariVC = link?.urlToSafariViewController() else {
            let linkError = UIAlertController.init(title: Strings.errorAlertTitle, message: Strings.errorMessageForBrokenLinks, preferredStyle: .alert)
            present(linkError, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                linkError.dismiss(animated: true, completion: nil)
            }
            return
        }
        present(safariVC, animated: true, completion: nil)
    }
}
