//
//  AddReviewViewController.swift
//  ProductReview
//
//  Created by Pisit Lolak on 29/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    @IBAction func back(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
     }
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
