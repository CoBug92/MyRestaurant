//
//  MyRestaurantTableViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 03/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit
import CoreData

class MyRestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
    }
    
    var restaurants: [Restaurant] = []
    var searchController: UISearchController! //Объект который занимается поиском
    var filterResultArray: [Restaurant] = [] //массив в который будет помещаться все результаты которые удовлетворяют поиску
    var fetchResultsController: NSFetchedResultsController<Restaurant>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Work with searchBar
        searchController = UISearchController(searchResultsController: nil) //Nil because we want that point of entry blocked main list
        searchController.searchResultsUpdater = self    //какой котроллер будет обновлять результаты
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false //if true the controller dims
        tableView.tableHeaderView = searchController.searchBar  //SearchBar located in the header of table
        definesPresentationContext = true //SearchBar works only on the mainPage (doesn't save in detailView)
        
        //Create query
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        //Create descriptor
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        //For getting data
        fetchRequest.sortDescriptors = [sortDescriptor]
        //Create context
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            //try to take data
            do {
                try fetchResultsController.performFetch()
                //all data write in restaurants
                restaurants = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print("Couldn't save data \(error.localizedDescription)")
            }
            //reload table
            tableView.reloadData()
        }
        
        //Clear unnecessary dividers
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Change the interface of BACK button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        //Autosizing cell
        self.tableView.estimatedRowHeight = 85                      //default height of cell (for increase capacity)
        self.tableView.rowHeight = UITableViewAutomaticDimension    //Height is calculated automatically
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchController.hidesNavigationBarDuringPresentation = false
        //NavigationBar hides
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        let wasInWatched = userDefaults.bool(forKey: "wasInWatched")
        
        guard !wasInWatched else { return }
        
        //Вызов PageViewController по его идентификатору
        if let PageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController {
            //отображаем контроллер
            present(PageViewController, animated: true, completion: nil)
        }
        
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    //Count of sections in TableView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterResultArray.count
        } else {
            return restaurants.count       //Count of rows in Section
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyRestaurantTableViewCell
        let restaurant = restaurantToDisplayAt(indexPath: indexPath)
        //Configurate the cell:
        //Writes the value of MyRestaurant.name in nameLabel
        cell.nameLabel.text = restaurant.name
        //Writes the value of MyRestaurant.type in typeLabel
        cell.typeLabel.text = restaurant.type
        //Writes the value of MyRestaurant.location in locationLabel
        cell.locationLabel.text = restaurant.location
        cell.checkImageView.isHidden = !restaurant.wasVisited
        //Write the value of MyRestaurant.image in thumbnailImageView
        cell.thumbnailImageView.image = UIImage(data: restaurant .image as! Data)
        //Create the round pictures
        //The side of square is equal the diameter of circle, that why /2
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.height/2
        cell.thumbnailImageView.clipsToBounds = true    //Give access to change the ImageView
        return cell
    }
    
    //Function creates swipe menu with additional buttons
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Create variable which will responsible for delete button
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            let context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
            let objectToDelete = self.fetchResultsController.object(at: indexPath)
            context.delete(objectToDelete)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }
        
        //Create action menu when user clicks "Share"
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            // Share item by indexPath
            let defaultText = "I am in \(self.restaurants[indexPath.row].name) now"
            if let image = UIImage(data: self.restaurants[indexPath.row].image as! Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        //Change the color of Share button
        shareAction.backgroundColor = UIColor(red: 63 / 255, green: 84 / 255, blue: 242 / 255, alpha: 1)
        //return 2 possible button in action menu
        return [deleteAction, shareAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Delete selecting of row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: - Fetch results controller delegate
    //вызывается перед тем как контроллер поменяет свой контент
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
        tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else { break }
        tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else { break }
        tableView.reloadRows(at: [indexPath], with: .fade)
        default: tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    
    //MARK: - Functions
    //метод для отфильтровки результатов для filterResultArray
    func filterContentSearch(searchText text: String){
        filterResultArray = restaurants.filter{ (restaurant) -> Bool in
            //в наш массив попадают элементы restaurant с маленькой буквы
            return (restaurant.name?.lowercased().contains(text.lowercased()))!
        }
    }
    
    func restaurantToDisplayAt(indexPath: IndexPath) -> Restaurant{
        let restaurant: Restaurant
        if searchController.isActive && searchController.searchBar.text != "" {
            restaurant = filterResultArray[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        return restaurant
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! DetailsViewController
                destinationVC.restaurant = restaurantToDisplayAt(indexPath: indexPath)
            }
        }
    }
    
    //    //The massive responsible for Restaurant objects
    //    var MyRestaurant: [Restaurant] = [
    //        Restaurant(name: "Barrafina", type: "Bar", image: "Barrafina", location: "10 Adelaide Street, Covent Garden, London", wasVisited: false),
    //        Restaurant(name: "Bourkestreetbakery", type: "Bakery", image: "Bourkestreetbakery", location: "480 Bourke St, Melbourne VIC 3000, Australia", wasVisited: false),
    //        Restaurant(name: "Cafe Deadend", type: "Cafe", image: "Cafedeadend", location: "72 Po Hing Fong, Hong Kong", wasVisited: false),
    //        Restaurant(name: "Cafe Lore", type: "Cafe", image: "Cafelore", location: "4601 4th Ave, Brooklyn, NY 11220, United States", wasVisited: false),
    //        Restaurant(name: "Confessional", type: "Restaurant", image: "Confessional", location: "308 E 6th St, New York, NY 10003, USA", wasVisited: false),
    //        Restaurant(name: "Donostia", type: "Restaurant", image: "Donostia", location: " 10 Seymour Pl, London W1H 7ND, United Kingdom", wasVisited: false),
    //        Restaurant(name: "Five Leaves", type: "Bar", image: "Fiveleaves", location: "18 Bedford Ave, Brooklyn, NY 11222, United States", wasVisited: false),
    //        Restaurant(name: "For Kee", type: "Restaurant", image: "Forkeerestaurant", location: "200 Hollywood Rd, Sheung Wan, Hong Kong", wasVisited: false),
    //        Restaurant(name: "Graham avenue meats", type: "Restaurant", image: "Grahamavenuemeats", location: "445 Graham Ave, Brooklyn, NY 11211, United States", wasVisited: false),
    //        Restaurant(name: "Haigh's chocolate", type: "Chocolate shope", image: "Haighschocolate", location: "The Strand Arcade, 1/412-414 George St, Sydney NSW 2000, Australia", wasVisited: false),
    //        Restaurant(name: "Homei", type: "Restaurant", image: "Homei", location: "Shop 8/38-52 Waterloo St, Surry Hills NSW 2010, Australia", wasVisited: false),
    //        Restaurant(name: "Palomino Espresso", type: "Espresso Bar", image: "Palominoespresso", location: "1/61 York St, Sydney NSW 2000, Australia", wasVisited: false),
    //        Restaurant(name: "Po's Atelier", type: "Bakery", image: "Posatelier", location: "70 Po Hing Fong, Hong Kong", wasVisited: false),
    //        Restaurant(name: "Teakha", type: "Cafe", image: "Teakha", location: "18 Tai Ping Shan St, Hong Kong", wasVisited: false),
    //        Restaurant(name: "Traif", type: "Restaurant", image: "Traif", location: "229 S 4th St, Brooklyn, NY 11211, United States", wasVisited: false),
    //        Restaurant(name: "Upstate", type: "Seafood Restaurant", image: "Upstate", location: "95 1st Avenue, New York, NY 10003, United States", wasVisited: false),
    //        Restaurant(name: "Waffle & Wolf", type: "Sandwich Shop", image: "Wafflewolf", location: "413 Graham Ave, Brooklyn, NY 11211, United States", wasVisited: false)
    //    ]
}

extension MyRestaurantTableViewController: UISearchResultsUpdating {
    //метод автоматически срабатывает когда мы что либо меняем в поисковой строке
    func updateSearchResults(for searchController: UISearchController) {
        filterContentSearch(searchText: searchController.searchBar.text!)
        tableView.reloadData() //заново срабатывае cellForRowAtIndexPath
    }
}

extension MyRestaurantTableViewController: UISearchBarDelegate {
    //когда мы щелкнули на поисковую строку
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            navigationController?.hidesBarsOnSwipe = false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationController?.hidesBarsOnSwipe = true
    }
}
