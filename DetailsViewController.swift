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
    //переход на этот экран
    @IBAction func close(seque: UIStoryboardSegue){
        
    }
    var restaurant: Restaurant! //переменная куда будут передаваться значения фоток
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Подгружаем нужную фотку
        self.restaurantImageView.image = UIImage(named: restaurant.image)
        //Убираем ненужные разделители
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        //Название в navigationBar будет по названию  ресторана
        title = restaurant.name
        //Автоматическое изменение высоты ячейки
        self.tableView.estimatedRowHeight = 44 //изначальный размер ячейки (также для повышения производительности)
        self.tableView.rowHeight = UITableViewAutomaticDimension //высота вычисляется автоматически
    }
    
    //Функция которая отвечает за показ navigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailsTableViewCell
        
        //отображение информации в ячейках
        
        
        //    if indexPath.row == 0 {
        //      cell.keyLabel.text = "Название"
        //      cell.valueLabel.text = restaurant.name
        //    }
        //    if indexPath.row == 1 {
        //      cell.keyLabel.text = "Тип"
        //      cell.valueLabel.text = restaurant.type
        //    }
        
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
