//
//  AddReviewViewController.swift
//  ProductReview
//
//  Created by Pisit Lolak on 29/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddReviewViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productDescriptionHead: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var fairButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var reviewName: SkyFloatingLabelTextField!
    @IBOutlet weak var reviewDescription: SkyFloatingLabelTextField!
    @IBOutlet weak var addReviewButton: UIButton!
    private var state: ReviewData.ratingStatus = .Fair
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        likeButton.setBackgroundImage(nil, for: .normal)
        fairButton.setBackgroundImage(nil, for: .normal)
        sadButton.setBackgroundImage(nil, for: .normal)
        if let product = product {
            productImage.image = product.photo
            productName.text = product.name
            productPrice.text = "\(product.price) ฿"
            productDescriptionHead.text = "รายละเอียดสินค้า"
            productDescription.text = product.productDescription
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Actions
    @IBAction func likeAction(_ sender: Any) {
        likeButton.setBackgroundImage(UIImage(named: "emoticonLike"), for: .normal)
        fairButton.setBackgroundImage(nil, for: .normal)
        sadButton.setBackgroundImage(nil, for: .normal)
        state = .Like
    }
    
    @IBAction func fairAction(_ sender: Any) {
        likeButton.setBackgroundImage(nil, for: .normal)
        fairButton.setBackgroundImage(UIImage(named: "emoticonFair"), for: .normal)
        sadButton.setBackgroundImage(nil, for: .normal)
        state = .Fair
    }
    
    @IBAction func sadAction(_ sender: Any) {
        likeButton.setBackgroundImage(nil, for: .normal)
        fairButton.setBackgroundImage(nil, for: .normal)
        sadButton.setBackgroundImage(UIImage(named: "emoticonSad"), for: .normal)
        state = .Sad
    }
    
    
    @IBAction func addReviewButton(_ sender: Any) {
        
    }
    
    // MARK: - Navigation
    @IBAction func back(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
     }
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let button = sender as? UIButton, button === addReviewButton else {
            return
        }
        let name = reviewName.text
        let description = reviewDescription.text
        product?.addReview(review: ReviewData(name: name!, rating: state, date: "", description: description!))
    }
    

}
