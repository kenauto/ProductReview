//
//  ProductCollectionViewController.swift
//  ProductReview
//
//  Created by Pisit Lolak on 6/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit
import SwiftMessages

private let reuseIdentifier = "Cell"

class ProductCollectionViewController: UICollectionViewController {
    //MARK: Properties
    var Products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        for pd in CoreDataManager.fetchProductData(){
            Products.append(pd.values)
        }
        if Products.count == 0{
            loadSampleProduct()
            CoreDataManager.saveProductToPersistData(datas: Products)
        }
        Products = sortProduct(products: Products)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        Products = sortProduct(products: Products)
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
    //MARK: Actions
    @IBAction func unwindToProductList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddProductViewController, let product = sourceViewController.product, let deleteState = sourceViewController.deleteState {
            if let selectedIndexPath = collectionView?.indexPathsForSelectedItems?.first{
                var msgConfig = SwiftMessages.defaultConfig
                msgConfig.presentationStyle = .top
                msgConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
                msgConfig.duration = .seconds(seconds: 2)
                if deleteState{
                    let pdName = Products[selectedIndexPath.item-1].name
                    print("delete item at \(pdName)")
                    let deleteSuccess = MessageView.viewFromNib(layout: .messageView)
                    deleteSuccess.configureTheme(.error)
                    deleteSuccess.configureDropShadow()
                    deleteSuccess.configureContent(title: "Delete", body: "Delete item name '\(pdName)'")
                    deleteSuccess.button?.isHidden = true
                    SwiftMessages.show(config: msgConfig, view: deleteSuccess)
                    Products.remove(at: (selectedIndexPath.item-1))
                }
                else if selectedIndexPath.item != 0{
                    Products[selectedIndexPath.item-1] = product
                    collectionView?.reloadItems(at: [selectedIndexPath])
                    let editSuccess = MessageView.viewFromNib(layout: .messageView)
                    editSuccess.configureTheme(.warning)
                    editSuccess.configureDropShadow()
                    editSuccess.configureContent(title: "Edit", body: "Edit item name '\(Products[selectedIndexPath.item-1].name)'")
                    editSuccess.button?.isHidden = true
                    SwiftMessages.show(config: msgConfig, view: editSuccess)
                }
                else {
                    let newIndexPath = IndexPath(row: Products.count+1, section: 0)
                    
                    Products.append(product)
                    collectionView?.insertItems(at: [newIndexPath])
                    let addSuccess = MessageView.viewFromNib(layout: .messageView)
                    addSuccess.configureTheme(.success)
                    addSuccess.configureDropShadow()
                    addSuccess.configureContent(title: "Add", body: "Add item name '\(product.name)'")
                    addSuccess.button?.isHidden = true
                    SwiftMessages.show(config: msgConfig, view: addSuccess)
                }
            }
        }
        if let sourceViewController = sender.source as? AddReviewViewController, let product = sourceViewController.product{
            let selectedIndexPath = collectionView?.indexPathsForSelectedItems?.first
            Products[(selectedIndexPath?.item)!-1] = product
            let addReviewSuccess = MessageView.viewFromNib(layout: .messageView)
            addReviewSuccess.configureTheme(.success)
            addReviewSuccess.configureDropShadow()
            addReviewSuccess.configureContent(title: "Add Review", body: "Add Review to item name '\(product.name)'")
            addReviewSuccess.button?.isHidden = true
            var msgConfig = SwiftMessages.defaultConfig
            msgConfig.presentationStyle = .top
            msgConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
            msgConfig.duration = .seconds(seconds: 2)
            SwiftMessages.show(config: msgConfig, view: addReviewSuccess)
        }
        CoreDataManager.saveProductToPersistData(datas: Products)
    }
    
    //MARK: Private function
    private func loadSampleProduct(){
        let photo1 = UIImage(named: "product1")
        let photo2 = UIImage(named: "product2")
        let photo3 = UIImage(named: "product3")
        let description1 = """
                            กาแฟอาราบิก้าคั่วกลาง แบบเมล็ด ขนาด 250 กรัม รสชาติกลมกล่อม กลิ่นหอม ยังคงความเป็นผลไม้และความสดชื่น เงื่อนไขการสั่งสินค้า/ คำแนะนำ สินค้าซื้อแล้วไม่สามารถปรับ เปลี่ยน หรือคืนได้ ยกเว้น สินค้าชำรุด/เสียหาย ไม่เป็นไปตามรูปที่แสดงเท่านั้น จัดจำหน่ายและจัดส่งโดย Abonzo Coffee. สอบถามข้อมูลเพิ่มเติมเกี่ยวกันสินค้า ติดต่อ คุณภัทรชัย 091-070-7272
                            """

        let ratingDatas: [ReviewData] = []
        
        let product1 = Product(name: "กาแฟ Abonzo คั่วกลาง", price: "180", photo: photo1, ratingS: 0, ratingF :0, ratingL:0, description: description1,ratings: ratingDatas)
        let product2 = Product(name: "กาแฟอาราบิก้าคั่วอ่อน", price: "200", photo: photo2, ratingS: 0, ratingF :0, ratingL:0, description: description1,ratings: ratingDatas)
        let product3 = Product(name: "กาแฟอาราบิก้าคั่วเข้ม", price: "200", photo: photo3, ratingS: 0, ratingF :0, ratingL:0, description: description1,ratings: ratingDatas)
        Products += [product1,product2,product3]
    }
    func sortProduct(products:[Product])->[Product]{
        var sortedProducts: [Product] = products
        sortedProducts.sort {
            
            ($0.reviews?.count)! > ($1.reviews?.count)!
            
        }
        return sortedProducts
    }
    
}
