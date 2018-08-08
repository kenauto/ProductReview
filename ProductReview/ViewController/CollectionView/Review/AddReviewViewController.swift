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
    let date = Date()
    let formatter = DateFormatter()
    var dateResult :String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        likeButton.setBackgroundImage(nil, for: .normal)
        fairButton.setBackgroundImage(UIImage(named: "emoticonFair"), for: .normal)
        sadButton.setBackgroundImage(nil, for: .normal)
        if let product = product {
            productImage.image = product.photo
            productName.text = product.name
            productPrice.text = "\(product.price) ฿"
            productDescriptionHead.text = "รายละเอียดสินค้า"
            productDescription.text = product.productDescription
        }
        formatter.dateFormat = "dd MM yy"
        
        dateResult = formatter.string(from: date)
        // Do any additional setup after loading the view.
        changeDate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeDate(){
        var dmy = dateResult.components(separatedBy: " ")
        var dmyChanged: [String] = []
        
        dmyChanged.append(dmy[0].replacingOccurrences(of: "0", with: ""))
        dmyChanged.append(dmy[1].replacingOccurrences(of: "0", with: ""))
        let m: Int = Int(dmy[1])!
        switch m {
        case 1:
            dmyChanged[1] = "ม.ค."
        case 2:
            dmyChanged[1] = "ก.พ."
        case 3:
            dmyChanged[1] = "มี.ค."
        case 4:
            dmyChanged[1] = "เม.ย."
        case 5:
            dmyChanged[1] = "พ.ค."
        case 6:
            dmyChanged[1] = "มิ.ย."
        case 7:
            dmyChanged[1] = "ก.ค."
        case 8:
            dmyChanged[1] = "ส.ค."
        case 9:
            dmyChanged[1] = "ก.ย."
        case 10:
            dmyChanged[1] = "ต.ค."
        case 11:
            dmyChanged[1] = "พ.ย."
        case 12:
            dmyChanged[1] = "ธ.ค."
        default:
            dmyChanged[1] = ""
        }
        var y: Int = Int(dmy[2])!
        y = y + 43
        y = y % 100
        dateResult = dmyChanged[0]+" "+dmyChanged[1]+" \(y)"
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
        product?.addReview(review: ReviewData(name: name!, rating: state.rawValue, date: dateResult, description: description!))
    }
    

}
