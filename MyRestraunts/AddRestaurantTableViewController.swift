//
//  AddRestaurantTableViewController.swift
//  MyRestraunts
//
//  Created by p1us on 04.07.15.
//  Copyright (c) 2015 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var wasVisited = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Colors of buttons
        noButton.backgroundColor = UIColor(red: 0, green: 120 / 255, blue: 10 / 255, alpha: 1.0)
        yesButton.backgroundColor = UIColor.gray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Check row which user will tap if it ImageRow
        if (indexPath as NSIndexPath).row == 0 {
            //Check access to photoLibrary
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                //Editing photo isn't availible
                imagePicker.allowsEditing = false
                //Take photo
                imagePicker.sourceType = .photoLibrary
                //Display view
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //function for choosing image from photoLibrary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Create array with photo
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //how we input image
        imageView.contentMode = .scaleAspectFill
        //Give access to change
        imageView.clipsToBounds = true
        //Close photoLibrary window
        dismiss(animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //Create light navigationBar
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    @IBAction func saveRestaurant() {
        //Check that all textFields are not empty
        var error = ""
        if nameTextField.text!.isEmpty {
            error = "name"
        } else if typeTextField.text!.isEmpty {
            error = "type"
        } else if locationTextField.text!.isEmpty {
            error = "location"
        }
        if error != "" {
            let alertController = UIAlertController(title: "Ups!", message: "You hasn't filled " + error + " field", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            //Add action
            alertController.addAction(okAction)
            //Create action view
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        //        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //        let oneRestaurant = Restaurant(context: context)
        //        oneRestaurant.name = nameTextField.text!
        //        oneRestaurant.type = typeTextField.text!
        //        oneRestaurant.location = locationTextField.text!
        //        oneRestaurant.image = UIImagePNGRepresentation(self.imageView.image!) as NSData?
        //        oneRestaurant.wasVisited = wasVisited
        //        //Save data to CodeData
        //        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //        navigationController!.popViewController(animated: true)
        
        performSegue(withIdentifier: "unwindBackToHomeScreen", sender: self)
        
    }
    
    @IBAction func wasRestaurantVisited(_ sender: AnyObject) {
        
        let pressedButton = sender as! UIButton
        
        if pressedButton == yesButton {
            wasVisited = true
            yesButton.backgroundColor = UIColor(red: 0, green: 120 / 255, blue: 10 / 255, alpha: 1.0)
            noButton.backgroundColor = UIColor.gray
        } else if pressedButton == noButton {
            wasVisited = false
            noButton.backgroundColor = UIColor(red: 0, green: 120 / 255, blue: 10 / 255, alpha: 1.0)
            yesButton.backgroundColor = UIColor.gray
        }
    }
    
    
    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return NO if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return NO if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
}
