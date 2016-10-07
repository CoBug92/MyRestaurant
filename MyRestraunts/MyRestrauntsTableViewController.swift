//
//  MyRestrauntsTableViewController.swift
//  MyRestraunts
//
//  Created by Богдан Костюченко on 03/10/16.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class MyRestrauntsTableViewController: UITableViewController {
    
    var MyRestaurant: [Restaurant] = [
        Restaurant(name: "Mcdonalds", type: "Fastfood", image: "Mcdonalds", location: "Moscow", wasVisited: false),
        Restaurant(name: "Arpege", type: "Restaurants", image: "Arpege", location: "Paris", wasVisited: false),
        Restaurant(name: "Eleven Madison Park", type: "Restaurants", image: "Eleven Madison Park", location: "New York", wasVisited: false),
        Restaurant(name: "Pierre Herme", type: "Restaurants", image: "Pierre Herme", location: "Paris", wasVisited: false),
        Restaurant(name: "El Celler de Can Roca", type: "Restaurants", image: "El Celler de Can Roca", location: "Girona", wasVisited: false),
        Restaurant(name: "Den", type: "Restaurants", image: "Den", location: "Tokyo", wasVisited: false),
        Restaurant(name: "Dominique Crenn", type: "Restaurants", image: "Dominique Crenn", location: "San Francisco", wasVisited: false),
        Restaurant(name: "Maido", type: "Restaurants", image: "Maido", location: "Lima", wasVisited: false),
        Restaurant(name: "KFC", type: "Fastfood", image: "KFC", location: "Moscow", wasVisited: false),
        Restaurant(name: "Relae", type: "Restaurants", image: "Relae", location: "Copenhagen", wasVisited: false)
    ]
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MyRestaurant.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell" //Initial Identifier of cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyRestrauntsTableViewCell
        
        //Configurate the cell:
        //Write value of restrauntLocation[""] in locationLabel
        cell.nameLabel.text = MyRestaurant[indexPath.row].name
        
        //Write value of restrauntLocation[""] in locationLabel
        cell.locationLabel.text = MyRestaurant[indexPath.row].location
        
        //Write value of restrauntType[""] in locationLabel
        cell.typeLabel.text = MyRestaurant[indexPath.row].type
        
        //Write value of restrauntImage[""] in thumbnailImageView
        cell.thumbnailImageView.image = UIImage(named: MyRestaurant[indexPath.row].image)
        //Create a cercle image
        //cell.thumbnailImageView.frame.size.height/2 у нас квадратные изображения (сторона = диаметру вписанного в него окружности), так что применяем эту формулу
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.height/2
        //Give access to change the ImageView
        cell.thumbnailImageView.clipsToBounds = true
        
//        cell.accessoryType = MyRestaurant[indexPath.row].wasVisited ? .checkmark : .none //запись в тернарном виде
//        cell.tintColor = UIColor.black  //выбор цвета галочки
        
        return cell
    }
    
    //cкрытие TopBar
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //ФУНКЦИЯ ТОЛЬКО ДЛЯ ДОБАВЛЕНИЯ КНОПКИ УДАЛЕНИЯ
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        self.restrauntsWereVisited.remove(at: indexPath.row)
//        self.restoranImage.remove(at: indexPath.row)
//        self.restoranType.remove(at: indexPath.row)
//        self.restoranNames.remove(at: indexPath.row)
//        self.restoranLocation.remove(at: indexPath.row)
//        
//        //self.tableView.reloadData() //перезагрузка таблицы без анимации
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    }
//    
//    
//    //Дополнительные методы для свайпа
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (UITableViewRowAction, indexPath) in
            // share item at indexPath
            self.MyRestaurant.remove(at: indexPath.row)
            
            //self.tableView.reloadData() //перезагрузка таблицы без анимации
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.backgroundColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
        
        let allShareAction = UITableViewRowAction(style: .default, title: "Share") { (UITableViewRowAction, indexPath) in
            // share item at indexPath
            let allShareActionMenu = UIAlertController(title: nil, message: "Shere as", preferredStyle: .actionSheet)
            
            let emailShareAction = UIAlertAction(title: "Email share", style: .default, handler: nil)
            let facebookShareAction = UIAlertAction(title: "FaceBook share", style: .default, handler: nil)
            let vkontakteShareAction = UIAlertAction(title: "VKontake share", style: .default, handler: nil)
            let cancelShareAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            allShareActionMenu.addAction(emailShareAction)
            allShareActionMenu.addAction(facebookShareAction)
            allShareActionMenu.addAction(vkontakteShareAction)
            allShareActionMenu.addAction(cancelShareAction)
            
            self.present(allShareActionMenu, animated: true, completion: nil)
        }
        allShareAction.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        
        return [allShareAction, deleteAction]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    //Сейчас будет осуществляться переход. Подготовительная функция к переходу
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSegue" {  //Если наш идентификатор перехода является showDetailSegue
            if let indexPath = self.tableView.indexPathForSelectedRow{  // опциональная привязка + создание indexPath
                let destinationVC = segue.destination as! DetailsViewController //куда осуществляется переход
                destinationVC.restaurantDetailsImage = self.MyRestaurant[indexPath.row].image
            }
        }
     }
    
    
    
    
    
    
    
}
