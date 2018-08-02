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
        self.collectionView?.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        switch(segue.identifier ?? "") {

        case "AddItem":
            return

        case "showDetail":
            guard let ProductDetailViewController = segue.destination as? ProductDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }

            guard let selectedProductCell = sender as? ProductCollectionViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }

            guard let indexPath = collectionView?.indexPath(for: selectedProductCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }

            let selectedProduct = Products[indexPath.item-1]
            ProductDetailViewController.product = selectedProduct

        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
//        if segue.identifier == "showDetail" {
//            let productDetailViewController = segue.destination
//            let selectedProductCell = sender
//            let indexPath = Products[in]
//        }
    }
    

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
            cell.priceLabel.text = "\(product.price) ฿"
            cell.emoticonImageView.image = product.ratingEmoticon
            cell.ratingLabel.text = "\(product.highestRating)"
            cell.reviewLabel.text = "\(product.reviews?.count ?? 0) รีวิว"
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
            return reusableView
        case UICollectionElementKindSectionFooter:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath)
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
    //MARK: Actions
    @IBAction func unwindToProductList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddProductViewController, let product = sourceViewController.product {
            
            if let selectedIndexPath = collectionView?.indexPathsForSelectedItems?.first{
            if selectedIndexPath.item != 0{
                // Update an existing meal.
                Products[selectedIndexPath.item-1] = product
                collectionView?.reloadItems(at: [selectedIndexPath])
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: Products.count+1, section: 0)
                
                Products.append(product)
                collectionView?.insertItems(at: [newIndexPath])
            }
            }
        }
        if let sourceViewController = sender.source as? AddReviewViewController, let product = sourceViewController.product{
            let selectedIndexPath = collectionView?.indexPathsForSelectedItems?.first
            Products[(selectedIndexPath?.item)!-1] = product
            
        }
    }
    
    //MARK: Private function
    private func loadSampleProduct(){
        let photo1 = UIImage(named: "product1")
        let photo2 = UIImage(named: "product2")
        let photo3 = UIImage(named: "product3")
        let description1 = """
                            กาแฟอาราบิก้าคั่วกลาง แบบเมล็ด ขนาด 250 กรัม รสชาติกลมกล่อม กลิ่นหอม ยังคงความเป็นผลไม้และความสดชื่น เงื่อนไขการสั่งสินค้า/ คำแนะนำ สินค้าซื้อแล้วไม่สามารถปรับ เปลี่ยน หรือคืนได้ ยกเว้น สินค้าชำรุด/เสียหาย ไม่เป็นไปตามรูปที่แสดงเท่านั้น จัดจำหน่ายและจัดส่งโดย Abonzo Coffee. สอบถามข้อมูลเพิ่มเติมเกี่ยวกันสินค้า ติดต่อ คุณภัทรชัย 091-070-7272
                            """
        let ratingData1:ReviewData = ReviewData.init(name: "kenny", rating: ReviewData.ratingStatus.Like, date: "now", description: "good")
        let ratingData2:ReviewData = ReviewData.init(name: "kenny", rating: ReviewData.ratingStatus.Like, date: "now", description: "good")
        let ratingData3:ReviewData = ReviewData.init(name: "kenny", rating: ReviewData.ratingStatus.Like, date: "now", description: "good")
        let ratingDatas: [ReviewData] = []
        
        let product1 = Product(name: "กาแฟ Abonzo คั่วกลาง", price: "180", photo: photo1, ratingS: 0, ratingF :0, ratingL:0, description: description1,ratings: ratingDatas)
        let product2 = Product(name: "กาแฟอาราบิก้าคั่วอ่อน", price: "200", photo: photo2, ratingS: 0, ratingF :0, ratingL:0, description: description1,ratings: ratingDatas)
        let product3 = Product(name: "กาแฟอาราบิก้าคั่วเข้ม", price: "200", photo: photo3, ratingS: 0, ratingF :0, ratingL:0, description: description1,ratings: ratingDatas)
        let ratingData4:ReviewData = ReviewData.init(name: "kennie", rating: ReviewData.ratingStatus.Like, date: "now", description: "gooddddd")
        product1.addReview(review: ratingData4)
        product1.addReview(review: ratingData1)
        product1.addReview(review: ratingData4)
        product1.addReview(review: ratingData1)
        product1.addReview(review: ratingData4)
        product1.addReview(review: ratingData1)
        Products += [product1,product2,product3]
    }
    
    
}
