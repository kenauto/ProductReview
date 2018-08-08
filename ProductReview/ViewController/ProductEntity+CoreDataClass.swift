//
//  ProductEntity+CoreDataClass.swift
//  
//
//  Created by Pisit Lolak on 7/8/2561 BE.
//
//

import Foundation
import CoreData
import UIKit

@objc(ProductEntity)
public class ProductEntity: NSManagedObject {
    var values : Product{
        get {
            let review = self.review?.allObjects as! [ReviewEntity]
            var reviewsStructs = [ReviewData]()
            for rv in review {
                reviewsStructs.append(rv.values)
            }
            return Product(name: self.name!, price: self.price!, photo: UIImage(data: self.photo! as Data), ratingS: Int(self.ratingS), ratingF: Int(self.ratingF), ratingL: Int(self.ratingL), description: self.productDescription!, ratings: reviewsStructs)
        }
        set {
            self.mutableSetValue(forKey: "review").removeAllObjects()
            self.name = newValue.name
            self.photo = UIImagePNGRepresentation(newValue.photo!)! as NSData
            self.price = newValue.price
            self.productDescription = newValue.productDescription
            self.ratingF = Int32(newValue.ratingF)
            self.ratingS = Int32(newValue.ratingS)
            self.ratingL = Int32(newValue.ratingL)

            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            let context = appDelegate.persistentContainer.viewContext

            let entity = NSEntityDescription.entity(forEntityName: "Review", in: context)
            

            for review in newValue.reviews ?? [] {
                let productReview = ReviewEntity(entity: entity!, insertInto: context)
                productReview.values = review
                self.addToReview(productReview)
            }
        }
    }
}
