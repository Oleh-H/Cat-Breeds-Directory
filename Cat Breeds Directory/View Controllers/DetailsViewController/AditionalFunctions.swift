//
//  AditionalFunctions.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 10.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

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
        let image: UIImage = catsImage.image!
        let preparedString = model.stringForSharing()
        let activityController = UIActivityViewController(activityItems: [image, preparedString], applicationActivities: nil)
        
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
            changeCatImage()
        }
        tapToChangeLabel.textColor = .clear
    }
    
    
    
    func changeCatImage() {
        activityIndicatorForImage.isHidden = false
        activityIndicatorForImage.startAnimating()
        network.getAnotherImage(breedID: breedID) { (newImage) in
            switch newImage {
            case .success(let image):
                self.imageChangingAnimation(newImage: image)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.activityIndicatorForImage.stopAnimating()
                    self.presentAlert(error: error, isItForDetailsData: false)
                }
            }
        }
    }

    
    ///Animate changing of the cat image with fade out and fade in.
    func imageChangingAnimation(newImage: UIImage) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: {
                self.catsImage.alpha = 0
            }) {_ in
                self.catsImage.image = newImage
                
                self.activityIndicatorForImage.stopAnimating()
                UIView.animate(withDuration: 0.4) {
                    self.catsImage.alpha = 1
                }
            }
        }
    }
    
}
