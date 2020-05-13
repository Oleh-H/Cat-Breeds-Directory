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
    // Share image, name, temperament and description
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
    //load and display new  breed image on tap
    @IBAction func imageTapped(_ gestureRecignizer: UITapGestureRecognizer) {
        guard gestureRecignizer.view != nil else {
            return
        }
        
        if gestureRecignizer.state == .ended {
            
            activityIndicatorImage.isHidden = false
            activityIndicatorImage.startAnimating()
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
