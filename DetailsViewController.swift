//
//  DetailsViewController.swift
//  MyRestraunts
//
//  Created by Богдан Костюченко on 07/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var restaurantImageView: UIImageView!
    var restaurantDetailsImage: String! //переменная куда будут передаваться значения фоток
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.restaurantImageView.image = UIImage(named: restaurantDetailsImage)
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
