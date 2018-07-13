//
//  ProductDetailViewController.swift
//  ProductReview
//
//  Created by Pisit Lolak on 9/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UINavigationControllerDelegate {
    var product: Product?

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var descriptionHeadLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var productLikeRating: UILabel!
    @IBOutlet weak var productFairRating: UILabel!
    @IBOutlet weak var productBadRating: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = product{
            productImageView.image = product.photo
            productNameLabel.text = product.name
            productPriceLabel.text = product.price
            productDescriptionTextView.text = product.description
            descriptionHeadLabel.text = "รายละเอียดสินค้า"
            productLikeRating.text = "\(product.rating.like)"
            productFairRating.text = "\(product.rating.fair)"
            productBadRating.text = "\(product.rating.sad)"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
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
