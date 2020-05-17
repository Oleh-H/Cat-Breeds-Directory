//
//  AditionalFunctions.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 10.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension BreedDetailsViewController {
    
    
    //MARK: - Share button
    /**
     Present `UIActivityViewController` to share breed details of the view.
     
     `UIActivityViewController` appear to share current:
     
         * Image
         * Breed name with flag emoji of the breed origin
         * Breed temperament
         * Breed description
     
     - Important:
     Text composed to single string after the image.
     
     - Parameters:
        - sender: UIBarButtonItem
     
     */
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        guard let image = catsImage.image,
            let name = breedDetails.first?.breeds.first?.name,
            let temperament = breedDetails.first?.breeds.first?.temperament,
            let description = breedDetails.first?.breeds.first?.description else { return }
        let origin = emojiManager.emojiFlag(regionCode: breedDetails.first?.breeds.first?.countryCode ?? "") ?? ""
        let underlyingString = "\(name) \(origin)\n\nTemperament: \(temperament)\n\nDescription: \(description)"
        let activityController = UIActivityViewController(activityItems: [image, underlyingString], applicationActivities: nil)
        /*activityController.popoverPresentationController?.sourceView = sender*/ //for iPad
        
        present(activityController, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: Get another Image
    ///Load and display new breed image on tap
    ///
    ///`tapToChangeLabel` - get clear color after firs tap on the image.
    @IBAction func imageTapped(_ gestureRecignizer: UITapGestureRecognizer) {
        guard gestureRecignizer.view != nil else {
            return
        }
        
        if gestureRecignizer.state == .ended {
            
            activityIndicatorImage.isHidden = false
            activityIndicatorImage.startAnimating()
            model.getAnotherImage(breedID: breedID) { (newImage) in
                self.imageChangingAnimation(newImage: newImage)
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
                
                self.activityIndicatorImage.stopAnimating()
                self.activityIndicatorImage.isHidden = true
                UIView.animate(withDuration: 0.4) {
                    self.catsImage.alpha = 1
                }
            }
        }
    }
    
    
    
    //MARK: Safari View Controller
    //Present links in Safari ViewController
    func presentSafariVC(urlString: String?) {
        let safariViewController = model.prepareSafariVCForUrl(url: urlString!)
        present(safariViewController, animated: true, completion: nil)
    }
}
