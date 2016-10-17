//
//  DetailsViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 07/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    //Function responsible for close RatingView and ShareVIew
    @IBAction func close(seque: UIStoryboardSegue){
    }
    
    var restaurant: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Download nacessory image
        self.restaurantImageView.image = UIImage(data: restaurant.image! as Data)
        
        //Delete unnecessory dividers
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Autosizing cell
        self.tableView.estimatedRowHeight = 85                      //default height of cell (for increase capacity)
        self.tableView.rowHeight = UITableViewAutomaticDimension    //Height is calculated automatically
        
        //Change the view of BACK button in the MAP view
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back to details", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        //The title of page = name of restaurant
        title = restaurant.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //NavigationBar displays
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4    //Count of rows in Section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailsTableViewCell
        
        //Display information in the label
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.keyLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.keyLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.keyLabel.text = "Visited"
            cell.valueLabel.text = restaurant.wasVisited ? "Yes" : "No"
        default:
            cell.keyLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Compare number of row. If number of row is 2 (location) {
        if indexPath.row == 2 {
            //Go to the next View
            self.performSegue(withIdentifier: "ShowTheMap", sender: nil)
        }
        
        //Delete selecting of row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Compare number of row. If number of row is 2 (location) {
        if segue.identifier == "ShowTheMap" {
            let destinationVC = segue.destination as! MapRestaurantsLocationViewController
            //Sent value of restaurant in this class to restaurant in Map class
            destinationVC.restaurant = restaurant
        }
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
