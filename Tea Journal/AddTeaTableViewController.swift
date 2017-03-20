//
//  AddTeaTableViewController.swift
//  Tea Journal
//
//  Created by Polina Fiksson on 04/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import CoreData

let teaTypes = [
    "White",
    "Black",
    "Green",
    "Oolong",
    "Pu-Erh",
    "Herbal",
    "Matcha",
    "Blend",
    "Chai",
    "Yellow",
    "Red",
    "Fruit"
]

class AddTeaTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageToLoad: UIImageView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet var textFields: [UITextField]!
    
    var haveTried = true
    var tea:TeaMO!
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageToLoad.isUserInteractionEnabled = true
        imageToLoad.addGestureRecognizer(tapGestureRecognizer)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        pickerView.delegate = self
        pickerView.dataSource = self
        typeTextField.inputView = pickerView
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                            let imagePicker = UIImagePickerController()
                            imagePicker.delegate = self
                            imagePicker.allowsEditing = false
                            imagePicker.sourceType = .photoLibrary
                            //bring up the photo library
                            present(imagePicker, animated: true, completion: nil)
        }

    }
    
    @IBAction func editEnded(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return teaTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = teaTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teaTypes[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //delegate method
    //get the selected photo from the method's parameter
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage {
            imageToLoad.image = selectedImage
            imageToLoad.contentMode = .scaleAspectFill
            imageToLoad.clipsToBounds = true
        }
        let leadingConstraint = NSLayoutConstraint(item: imageToLoad, attribute:
            NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem:
            imageToLoad.superview, attribute: NSLayoutAttribute.leading, multiplier: 1,
                                      constant: 0)
        leadingConstraint.isActive = true
        let trailingConstraint = NSLayoutConstraint(item: imageToLoad,
            attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal,
            toItem: imageToLoad.superview, attribute: NSLayoutAttribute.trailing,
            multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        let topConstraint = NSLayoutConstraint(item: imageToLoad, attribute:
            NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem:
            imageToLoad.superview, attribute: NSLayoutAttribute.top, multiplier: 1,
                                      constant: 0)
        topConstraint.isActive = true
        let bottomConstraint = NSLayoutConstraint(item: imageToLoad, attribute:
            NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem:
            imageToLoad.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1,
                                      constant: 0)
        bottomConstraint.isActive = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTea(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || brandTextField.text == "" {
            let alertController = UIAlertController(title: "Missing Field", message: "One of the required fields is blank", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }else{
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            tea = TeaMO(context:
                appDelegate.persistentContainer.viewContext)
            tea.name = nameTextField.text
            tea.type = typeTextField.text
            tea.brand = brandTextField.text
            tea.haveTried = haveTried
            if let teaImage = imageToLoad.image {
                //get the data of a specified image in PNG format
                if let imageData = UIImagePNGRepresentation(teaImage) {
                    //convert it to an NSData object
                    tea.image = NSData(data: imageData)
                }
            }
            appDelegate.saveContext()
        }
        
            dismiss(animated: true, completion: nil)}
        
    }
    
    @IBAction func toggleHaveTriedButton(sender: UIButton) {
        // Yes button clicked
        if sender == yesButton {
            haveTried = true
            
            // Change the backgroundColor property of yesButton to purple
            yesButton.backgroundColor = UIColor(red: 174.0/255.0, green: 164.0/255.0, blue: 191.0/255.0, alpha: 1.0)
            
            // Change the backgroundColor property of noButton to gray
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            
        } else if sender == noButton {
            haveTried = false
            
            // Change the backgroundColor property of yesButton to gray
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            
            // Change the backgroundColor property of noButton to purple
            noButton.backgroundColor = UIColor(red: 174.0/255.0, green: 164.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        }
    }
    
    


}
