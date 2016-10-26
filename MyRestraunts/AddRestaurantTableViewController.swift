//
//  AddRestaurantTableViewController.swift
//  MyRestraunts
//
//  Created by p1us on 04.07.15.
//  Copyright (c) 2015 Ivan Akulov. All rights reserved.
//

import UIKit

class AddRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var locationErrorLabel: UILabel!
    @IBOutlet weak var typeErrorLabel: UILabel!
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var wasVisited = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Buttons color
        yesButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        noButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Iteration which describe action when user touch photo row
        if indexPath.row == 0 {
            //Create alertController which show possible action
            let allertController = UIAlertController(title: NSLocalizedString("Choose right action", comment: "Choose right action"), message: nil, preferredStyle: .actionSheet)
            //Create possible action
            let cancelAction = UIAlertAction(title: NSLocalizedString( "Camera", comment:  "Camera"), style: .default, handler: {(action) in
                self.chooseImagePickerAction(source: .camera)
            })
            let photoLibraryAction = UIAlertAction(title: NSLocalizedString("Photo Library", comment: "Photo Library") , style: .default, handler: { (action) in
                self.chooseImagePickerAction(source: .photoLibrary)
            })
            let cameraAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
            //Add all action in the actionSheet
            allertController.addAction(cameraAction)
            allertController.addAction(photoLibraryAction)
            allertController.addAction(cancelAction)
            //Present alertController
            self.present(allertController, animated: true, completion: nil)
        }
        //Delete highlighting of rows when user touched
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: - Functions
    func chooseImagePickerAction(source: UIImagePickerControllerSourceType) {
        //Check access to a photoLibrary and a Camera
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            //Editing photo is availible
            imagePicker.allowsEditing = true
            //Choose photo or take a photo
            imagePicker.sourceType = source
            //Display view
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //function for choosing image from photoLibrary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Create an array with photos
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        //How we input an image
        imageView.contentMode = .scaleAspectFill
        //Give access to change an image
        imageView.clipsToBounds = true
        //Close photoLibrary's window
        dismiss(animated: true, completion: nil)
    }
    
    //Function check filling textField
    func checkFillingTextField() -> Int {
        var error = 0
        //Check that all textFields are not empty
        if nameTextField.text == "" {
            nameErrorLabel.isHidden = false
            error += 1
        } else {
            nameErrorLabel.isHidden = true
        }
        if typeTextField.text == "" {
            typeErrorLabel.isHidden = false
            error += 1
        } else {
            typeErrorLabel.isHidden = true
        }
        if locationTextField.text == "" {
            locationErrorLabel.isHidden = false
            error += 1
        } else {
            locationErrorLabel.isHidden = true
        }
        return error
    }
    
    
    
    //MARK: - Actions
    @IBAction func saveRestaurant() {
        //get error value
        let error = checkFillingTextField()
        if error == 0 {
            //get context with whom we will work
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                //create copy our class in the context
                let restaurant = Restaurant(context: context)
                //Add all value in a Restaurant
                restaurant.name = nameTextField.text
                restaurant.type = typeTextField.text
                restaurant.location = locationTextField.text
                restaurant.wasVisited = wasVisited
                if let image = imageView.image {
                    // As we expect to get binary data so we cast to NSData
                    restaurant.image = UIImagePNGRepresentation(image) as NSData?
                }
                //Save context
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Couldn't save data \(error), \(error.userInfo)")
                }
            }
            //Return to main page
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
            sender.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            yesButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
