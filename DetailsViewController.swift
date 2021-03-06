//
//  DetailsViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 07/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit
import CoreData


class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var restaurant: Restaurant?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //NavigationBar displays
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if restaurant?.rate == nil {
           rateButton.setImage(UIImage(named: "rating"), for: UIControlState.normal)
        } else {
            rateButton.setImage(UIImage(named: (restaurant?.rate)!), for: UIControlState.normal)
        }
        
        //Download nacessory image
        self.restaurantImageView.image = UIImage(data: restaurant?.image as! Data)
        
        //Autosizing cell
        self.tableView.estimatedRowHeight = 35                    //default height of cell (for increase capacity)
        self.tableView.rowHeight = UITableViewAutomaticDimension    //Height is calculated automatically
        
        //Delete unnecessory separaties
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Change the view of BACK button in the MAP view
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back to details", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        //The title of page = name of restaurant
        title = restaurant!.name
    }
    
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4    //Count of rows in Section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailsTableViewCell
        
        //Display information in the label
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Name"
            cell.valueLabel.text = restaurant!.name
        case 1:
            cell.keyLabel.text = "Type"
            cell.valueLabel.text = restaurant!.type
        case 2:
            cell.keyLabel.text = "Location"
            cell.valueLabel.text = restaurant!.location
        case 3:
            cell.keyLabel.text = "Visited"
            cell.valueLabel.text = restaurant!.wasVisited ? "Yes" : "No"
        default:
            cell.keyLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Compare number of row. If number of row is 2 (location) {
        if indexPath.row == 2 {
            //Go to the mapView
            self.performSegue(withIdentifier: "ShowTheMap", sender: nil)
        }
        //Delete selecting of row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Compare number of row. If number of row is 2 (location) {
        if segue.identifier == "ShowTheMap" {
            let destinationVC = segue.destination as! MapRestaurantsLocationViewController
            //Sent value of restaurant in this class to restaurant in Map class
            destinationVC.restaurant = restaurant
        }
        if segue.identifier == "ShowTheMapButton" {
            let destinationVC = segue.destination as! MapRestaurantsLocationViewController
            //Sent value of restaurant in this class to restaurant in Map class
            destinationVC.restaurant = restaurant
        }
    }
    
    
    //MARK: - Action
    //Function responsible for send rateImage or close RatingView and ShareVIew
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard let svc = segue.source as? QuickReviewViewController else { return }
        guard let rating = svc.restRating else { return }
        rateButton.setImage(UIImage(named: rating), for: .normal)
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            //Add all value in a Restaurant
            restaurant?.rate = rating
            //Save context
            do {
                try context.save()
            } catch let error as NSError {
                print("Couldn't save data \(error), \(error.userInfo)")
            }
        }
    }
}
