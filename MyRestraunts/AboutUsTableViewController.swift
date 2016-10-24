//
//  AboutUsTableViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 24/10/2016.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class AboutUsTableViewController: UITableViewController {
    
    
    let sectionsHeaders = ["We are in the social networks", "Our sites"]
    let sectionsContent = [["facebook", "vk", "linkdin"],["https://github.com/CoBug92"]]
    let firstSectionsLinks = [["https://www.facebook.com/CoBugs", "https://vk.com/kostyuchenkobogdan", "https://www.linkedin.com/in/bogdan-kostyuchenko-17119ba0?trk=nav_responsive_tab_profile_pic"],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionsHeaders.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionsContent[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sectionsContent[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsHeaders[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
