//
//  AddRestaurantTableViewController.swift
//  MyRestraunts
//
//  Created by p1us on 04.07.15.
//  Copyright (c) 2015 Ivan Akulov. All rights reserved.
//

import UIKit

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
        noButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        yesButton.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Check row which user will tap if it ImageRow
        if indexPath.row == 0 {
            
            let allertController = UIAlertController(title: "Choose right action", message: nil, preferredStyle: .actionSheet)
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
                self.chooseImagePickerAction(source: .photoLibrary)
            })
            let cancelAction = UIAlertAction(title: "Camera", style: .cancel, handler: {(action) in
                self.chooseImagePickerAction(source: .camera)
            })
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: nil)
            allertController.addAction(cameraAction)
            allertController.addAction(photoLibraryAction)
            allertController.addAction(cancelAction)
            self.present(allertController, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func chooseImagePickerAction(source: UIImagePickerControllerSourceType) {
        //Check access to photoLibrary or to Camera
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            //Editing photo is availible
            imagePicker.allowsEditing = true
            //Choose photo or take photo
            imagePicker.sourceType = source
            //Display view
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //function for choosing image from photoLibrary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Create array with photo
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        //how we input image
        imageView.contentMode = .scaleAspectFill
        //Give access to change image
        imageView.clipsToBounds = true
        //Close photoLibrary window
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Action
    @IBAction func saveRestaurant() {
        //Check that all textFields are not empty
        if nameTextField.text == nil || typeTextField.text == nil || locationTextField.text == nil {
            let alertController = UIAlertController(title: "Ups!", message: "You hasn't filled field", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            //Add action
            alertController.addAction(okAction)
            //Create action view
            self.present(alertController, animated: true, completion: nil)
        } else {
            //добираемся до контекста с которым будем работать
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                //создаем экземпляр нашего класса в нашем контексте
                let restaurant = Restaurant(context: context)
                //устанавливаем все свойства
                restaurant.name = nameTextField.text!
                restaurant.type = typeTextField.text!
                restaurant.location = locationTextField.text!
                restaurant.wasVisited = wasVisited
                if let image = imageView.image {
                    restaurant.image = UIImagePNGRepresentation(image) as NSData?
                }
                //Save data to CodeData
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Couldn't save data \(error), \(error.userInfo)")
                }
            }
            performSegue(withIdentifier: "unwindSequeFromAddRestaurant", sender: self)
        }
    }
    
    @IBAction func wasRestaurantVisited(_ sender: UIButton) {
        if sender == yesButton {
            wasVisited = true
            sender.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            noButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else {
            wasVisited = false
            sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            yesButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
