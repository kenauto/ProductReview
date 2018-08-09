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


class AddProductViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UITextViewDelegate {
    
    
    //MARK: Property
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ProductImageView: UIImageView!
    @IBOutlet weak var productName: SkyFloatingLabelTextField!
    @IBOutlet weak var productPrice: SkyFloatingLabelTextField!
//    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productDescription: JVFloatLabeledTextView!
    @IBOutlet weak var deleteButtonItem: UIBarButtonItem!
    
    var product: Product?
    var ratingS = 0
    var ratingF = 0
    var ratingL = 0
    var deleteState: Bool? = false
    var reviews: [ReviewData]? = []
    
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
        if let button = sender as? UIButton, button === addButton {
            os_log("The save button was pressed", log: OSLog.default, type: .debug)
        }
        else{
            deleteState = true
        }
        
        let name = productName.text
        let price = "\(productPrice.text ?? "0")"
        //        let description = productDescription.text
        let photo = ProductImageView.image ?? #imageLiteral(resourceName: "defaultphoto_2x")
        let description = productDescription.text

        product = Product(name: name!, price: price, photo: photo,  ratingS: ratingS, ratingF: ratingF, ratingL: ratingL, description: description!, ratings: reviews)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDescription.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        if let product = product{
            ProductImageView.image = product.photo
            productName.text = product.name
            productPrice.text = product.price
           reviews = product.reviews
//            productDescription.float
//
            productDescription.text = product.productDescription
            ratingL = product.rating.like
            ratingF = product.rating.fair
            ratingS = product.rating.sad
        } else{
            deleteButtonItem.isEnabled = false
        }
        
        productDescription.font = UIFont(name: "SukhumvitSet-Text", size: 17.0)!
        DispatchQueue.main.async {
            self.productDescription.setBottomBorderWithColor(color: UIColor.darkGray, height: 1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.setBottomBorderWithColor(color: UIColor.darkGray, height: 1)
    }
}

