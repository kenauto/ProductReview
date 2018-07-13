//
//  ViewController.swift
//  ProductReview
//
//  Created by Pisit Lolak on 6/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import JVFloatLabeledTextField
import os.log

class AddProductViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate {
    
    
    //MARK: Property
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ProductImageView: UIImageView!
    @IBOutlet weak var productName: SkyFloatingLabelTextField!
    @IBOutlet weak var productPrice: SkyFloatingLabelTextField!
    @IBOutlet weak var productDescription: SkyFloatingLabelTextField!
    var product: Product?
    var ratingS = 0
    var ratingF = 0
    var ratingL = 0
    
    //MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        //        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        ProductImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === addButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = productName.text
        let price = "\(productPrice.text ?? "0")"
        //        let description = productDescription.text
        let photo = ProductImageView.image
        let description = productDescription.text
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        product = Product(name: name!, price: price, photo: photo,  ratingS: ratingS, ratingF: ratingF, ratingL: ratingL, review: "0", description: description!, ratings: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let product = product{
            ProductImageView.image = product.photo
            productName.text = product.name
            productPrice.text = product.price
            productDescription.text = product.description
            ratingL = product.rating.like
            ratingF = product.rating.fair
            ratingS = product.rating.sad
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

