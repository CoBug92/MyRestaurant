//
//  QuickReviewViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 10/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class QuickReviewViewController: UIViewController {
    
    @IBOutlet weak var windowView: UIView!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var sosoButton: UIButton!
    @IBOutlet weak var perfectButton: UIButton!
    
    var restRating: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Create darkBlurEffect
        let darkBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let darkBlurEffectView = UIVisualEffectView(effect: darkBlurEffect)
        darkBlurEffectView.frame = self.view.bounds
        darkBlurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(darkBlurEffectView, at: 1)
        
        //Create animation for rating
        badButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        sosoButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        perfectButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Create animation for markButtons
        let buttonArray = [badButton, sosoButton, perfectButton]
        for (index, button) in buttonArray.enumerated() {
            let delay = Double(index) * 0.2
            UIView.animate(withDuration: 0.6, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                button?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
        }
    }
    
    
    
    //MARK: -Action
    @IBAction func rateEateries (sender: UIButton) {
        switch sender.tag  {
        case 0:
            restRating = "bad"
        case 1:
            restRating = "soso"
        case 2:
            restRating = "perfect"
        default:
            break
        }
        performSegue(withIdentifier: "unwindSequeToDVC", sender: sender)
    }
    
}
