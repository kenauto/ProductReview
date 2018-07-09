//
//  ProductCollectionViewController.swift
//  ProductReview
//
//  Created by Pisit Lolak on 6/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductCollectionViewController: UICollectionViewController {
    //MARK: Properties
    var Products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        loadSampleProduct()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
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
        return Products.count+1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item{
        case 0:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "AddProductCollectionViewCell", for: indexPath)

        default:
            let cellIdentifier = "ProductCollectionViewCell"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProductCollectionViewCell else{
                fatalError()
            }
            // Configure the cell
            let product = Products[indexPath.row - 1]
            cell.photoImageView.image = product.photo
            cell.nameLabel.text = product.name
            cell.priceLabel.text = product.price
            cell.emoticonImageView.image = product.ratingEmoticon
            cell.ratingLabel.text = "\(product.rating)"
            cell.reviewLabel.text = "\(product.review)"
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
            return reusableView
        default:
            fatalError()
        }
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
    
    
    //MARK: Private function
    private func loadSampleProduct(){
        let photo1 = UIImage(named: "product1")
        let photo2 = UIImage(named: "product2")
        let photo3 = UIImage(named: "product3")
        let emoticonSad = UIImage(named: "emoticonSad")
        let emoticonFair = UIImage(named: "emoticonFair")
        let emoticonLike = UIImage(named: "emoticonLike")
        
        let product1 = Product(name: "กาแฟ Abonzo คั่วกลาง", price: "180 ฿", photo: photo1, rating: 60, ratingEmoticon: emoticonLike, review: "5 รีวิว")
        let product2 = Product(name: "กาแฟอาราบิก้าคั่วอ่อน", price: "200 ฿", photo: photo2, rating: 28, ratingEmoticon: emoticonFair, review: "9 รีวิว")
        let product3 = Product(name: "กาแฟอาราบิก้าคั่วเข้ม", price: "200 ฿", photo: photo3, rating: 0, ratingEmoticon: emoticonSad, review: "")
        Products += [product1,product2,product3]
    }
    
    
}
