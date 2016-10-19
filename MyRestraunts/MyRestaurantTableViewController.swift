//
//  MyRestaurantTableViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 03/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit
import CoreData

class MyRestaurantTableViewController: UITableViewController {
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
    }
    
    
    //    var myRestaurant: [Restaurants] = []
    //The massive responsible for Restaurant objects
    var allRestaurant: [Restaurant] = [
        Restaurant(name: "Barrafina", type: "Bar", image: "Barrafina", location: "10 Adelaide Street, Covent Garden, London", wasVisited: false),
        Restaurant(name: "Bourkestreetbakery", type: "Bakery", image: "Bourkestreetbakery", location: "480 Bourke St, Melbourne VIC 3000, Australia", wasVisited: false),
        Restaurant(name: "Deadend", type: "Cafe", image: "Cafedeadend", location: "72 Po Hing Fong, Hong Kong", wasVisited: false),
        Restaurant(name: "Lore", type: "Cafe", image: "Cafelore", location: "4601 4th Ave, Brooklyn, NY 11220, United States", wasVisited: false),
        Restaurant(name: "Confessional", type: "Restaurant", image: "Confessional", location: "308 E 6th St, New York, NY 10003, USA", wasVisited: false),
        Restaurant(name: "Donostia", type: "Restaurant", image: "Donostia", location: " 10 Seymour Pl, London W1H 7ND, United Kingdom", wasVisited: false),
        Restaurant(name: "Five Leaves", type: "Bar", image: "Fiveleaves", location: "18 Bedford Ave, Brooklyn, NY 11222, United States", wasVisited: false),
        Restaurant(name: "For Kee", type: "Restaurant", image: "Forkeerestaurant", location: "200 Hollywood Rd, Sheung Wan, Hong Kong", wasVisited: false),
        Restaurant(name: "Graham avenue meats", type: "Restaurant", image: "Grahamavenuemeats", location: "445 Graham Ave, Brooklyn, NY 11211, United States", wasVisited: false),
        Restaurant(name: "Haigh's chocolate", type: "Chocolate shope", image: "Haighschocolate", location: "The Strand Arcade, 1/412-414 George St, Sydney NSW 2000, Australia", wasVisited: false),
        Restaurant(name: "Homei", type: "Restaurant", image: "Homei", location: "Shop 8/38-52 Waterloo St, Surry Hills NSW 2010, Australia", wasVisited: false),
        Restaurant(name: "Palomino Espresso", type: "Espresso Bar", image: "Palominoespresso", location: "1/61 York St, Sydney NSW 2000, Australia", wasVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", image: "Posatelier", location: "70 Po Hing Fong, Hong Kong", wasVisited: false),
        Restaurant(name: "Teakha", type: "Cafe", image: "Teakha", location: "18 Tai Ping Shan St, Hong Kong", wasVisited: false),
        Restaurant(name: "Traif", type: "Restaurant", image: "Traif", location: "229 S 4th St, Brooklyn, NY 11211, United States", wasVisited: false),
        Restaurant(name: "Upstate", type: "Seafood Restaurant", image: "Upstate", location: "95 1st Avenue, New York, NY 10003, United States", wasVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Sandwich Shop", image: "Wafflewolf", location: "413 Graham Ave, Brooklyn, NY 11211, United States", wasVisited: false)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
        
        //        //get the data from coredata
        //        getData()
        //        //reload the tableview
        //        tableView.reloadData()
        
        
        //NavigationBar hides
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    //Count of sections in TableView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRestaurant.count       //Count of rows in Section
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyRestaurantTableViewCell
        
        //Configurate the cell:
        let eateries = allRestaurant[indexPath.row]
        //Writes the value of MyRestaurant.name in nameLabel
        cell.nameLabel.text = eateries.name
        
        //Writes the value of MyRestaurant.type in typeLabel
        cell.typeLabel.text = eateries.type
        
        //Writes the value of MyRestaurant.location in locationLabel
        cell.locationLabel.text = eateries.location
        
        cell.checkImageView.isHidden = !eateries.wasVisited
        
        //Write the value of MyRestaurant.image in thumbnailImageView
        cell.thumbnailImageView.image = UIImage(named: eateries.image)
        //Create the round pictures
        //The side of square is equal the diameter of circle, that why /2
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.height/2
        cell.thumbnailImageView.clipsToBounds = true    //Give access to change the ImageView
        
        return cell
    }
    
    
    
    //!    //Function creates swipe menu with additional buttons
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Create variable which will responsible for delete button
        //        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
        //            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //            let oneRestaurant = self.myRestaurant[indexPath.row]
        //            context.delete(oneRestaurant)
        //            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //            do {
        //                self.myRestaurant = try context.fetch(Eateries.fetchRequest())
        //            } catch {
        //                print("Fetching Failed")
        //            }
        //            tableView.reloadData()
        //        }
        
        //Create action menu when user clicks "Share"
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            // Share item by indexPath
            let defaultText = "I am in \(self.allRestaurant[indexPath.row].name) now"
            if let image = UIImage(named: self.allRestaurant[indexPath.row].image) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        //Change the color of Share button
        share.backgroundColor = UIColor(red: 63 / 255, green: 84 / 255, blue: 242 / 255, alpha: 1)
        //return 2 possible button in action menu
        return [share]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Delete selecting of row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //
    //    func getData() {
    //        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //        //get data
    //        do {
    //            MyRestaurant = try context.fetch(Restaurants.fetchRequest())
    //        } catch {
    //            print("Fetching Failed")
    //        }
    //    }
    //
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! DetailsViewController
                destinationVC.restaurant = allRestaurant[indexPath.row]
            }
        }
    }
    
    
    
    
    //Отмечаем галочкой посещеные рестораны
    //        cell.accessoryType = MyRestaurant[indexPath.row].wasVisited ? .checkmark : .none
    //        cell.tintColor = UIColor.black  //выбор цвета галочки
    
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        //Контроллер возможных действий:
    //        //создание view который появляется внизу с выбором действий, которые мы задали ниже
    //        let actionMenu = UIAlertController(title: nil, message: "What we need do?", preferredStyle: UIAlertControllerStyle.actionSheet)
    //
    //        //Создаем действия для контроллера
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) //Объявляем  кнопку cancel
    //        actionMenu.addAction(cancelAction)    //Добавляем в окошко кнопку cancel
    //
    //        //действия отвечающее за отметку о посещяемости и ее отмене
    //        let iHaveBeenThereAction = UIAlertAction(title: "I have been there", style: .default, handler: {(action: UIAlertAction!) -> Void in
    //            let cell = tableView.cellForRow(at: indexPath)
    //            cell?.accessoryType = .checkmark    //отмечаем галочкой
    //            self.restrauntsWereVisited[indexPath.count] = true  //заносим в массив значение false
    //        })
    //        let iHaveNeverBeenThereAction = UIAlertAction(title: "I have never been there", style: .default, handler: {(action: UIAlertAction!) -> Void in
    //            let cell = tableView.cellForRow(at: indexPath)
    //            cell?.accessoryType = .none    //отмечаем галочкой
    //            self.restrauntsWereVisited[indexPath.count] = false //заносим в массив значение false
    //        })
    //        let cell = tableView.cellForRow(at: indexPath)
    //        if cell?.accessoryType == .checkmark {
    //            actionMenu.addAction(iHaveNeverBeenThereAction)
    //        } else {
    //            actionMenu.addAction(iHaveBeenThereAction)
    //        }
    //
    //        //при нажатии на клавишу открывается Alert окно
    //        let callActionHandler = {(action: UIAlertAction!) -> Void in
    //            let warningMessage = UIAlertController(title: "The service doesn't work", message: "In this moment the ring cannot be complited", preferredStyle: .alert)
    //            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    //            warningMessage.addAction(okAction)
    //
    //            self.present(warningMessage, animated: true  , completion: nil)
    //        }
    //        let callAction = UIAlertAction(title: "Ring", style: .default, handler: callActionHandler)
    //        actionMenu.addAction(callAction) //Добавляем в окошко кнопку Ring
    //
    //        tableView.deselectRow(at: indexPath, animated: true)    //Чтобы нажатая ячейка не оставалась выделенной
    //
    //        self.present(actionMenu,animated: true, completion: nil)
    //    }
    
    //    //Hide the TopBar
    //    override var prefersStatusBarHidden: Bool{
    //        return true
    //    }
    
    //Function adds the delete button in the sliding menu
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            self.restaurantWereVisited.remove(at: indexPath.row)
    //            self.restaurantImage.remove(at: indexPath.row)
    //            self.restaurantType.remove(at: indexPath.row)
    //            self.restaurantNames.remove(at: indexPath.row)
    //            self.restaurantLocation.remove(at: indexPath.row)
    //        }
    //        self.tableView.reloadData() //перезагрузка таблицы без анимации
    //        tableView.deleteRows(at: [indexPath], with: .fade) //перезагрузка таблицы c анимацией
    //    }
    
}
