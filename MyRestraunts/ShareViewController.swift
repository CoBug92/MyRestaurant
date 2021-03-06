//
//  ShareViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 11/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var facebookShareVIew: UIView!
    @IBOutlet weak var googleShareView: UIView!
    @IBOutlet weak var vKontakeShareView: UIImageView!
    @IBOutlet weak var emailShareView: UIImageView!
    @IBOutlet weak var closeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Animation for a facebook button
        self.facebookShareVIew.transform = CGAffineTransform(translationX: -500 , y: -500)
        //Animation for a google buttom
        self.googleShareView.transform = CGAffineTransform(translationX: 500, y: -500)
        //Animation for a VKontake button
        self.vKontakeShareView.transform = CGAffineTransform(translationX: 500, y: 500)
        //Animation for an email button
        self.emailShareView.transform = CGAffineTransform(translationX: -500, y: 500)
        //Animation for a close button
        self.closeView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Animation for a facebook button
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
            self.facebookShareVIew.transform = CGAffineTransform(translationX: 0, y: 0)
            } , completion: nil)
        //Animation for a google buttom
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
            self.googleShareView.transform = CGAffineTransform(translationX: 0, y: 0)
            } , completion: nil)
        
        //Animation for a VKontake button
        UIView.animate(withDuration: 1, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
            self.vKontakeShareView.transform = CGAffineTransform(translationX: 0, y: 0)
            } , completion: nil)
        
        //Animation for an email button
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
            self.emailShareView.transform  = CGAffineTransform(translationX: 0, y: 0)
            } , completion: nil)
        
        //Animation for a close button
        UIView.animate(withDuration: 1, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
            self.closeView.transform = CGAffineTransform(translationX: 0, y: 0)
            } , completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
