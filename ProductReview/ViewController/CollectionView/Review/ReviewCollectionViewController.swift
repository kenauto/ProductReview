//
//  ReviewCollectionViewController.swift
//  ProductReview
//
//  Created by Pisit Lolak on 14/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ReviewCollectionViewController: UICollectionViewController {

    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (product?.reviews?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "ReviewCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ReviewCollectionViewCell else{
            fatalError()
        }
        // Configure the cell
        let review = product?.reviews![indexPath.item]
        switch review?.rating{
        case .Fair?:
            cell.reviewPicture.image = #imageLiteral(resourceName: "emoticonFair")
        case .Like?:
            cell.reviewPicture.image = #imageLiteral(resourceName: "emoticonLike")
        default:
            cell.reviewPicture.image = #imageLiteral(resourceName: "emoticonSad")
            
        }
        cell.reviewName.text = review?.name
        cell.reviewDate.text = review?.date
        cell.reviewDescription.text = review?.description
        cell.layer.borderWidth = 0.7
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.masksToBounds = false
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
