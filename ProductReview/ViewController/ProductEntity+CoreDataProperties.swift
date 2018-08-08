//
//  ProductEntity+CoreDataProperties.swift
//  
//
//  Created by Pisit Lolak on 7/8/2561 BE.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "Product")
    }

    @NSManaged public var highestRating: Int32
    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var price: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var ratingF: Int32
    @NSManaged public var ratingL: Int32
    @NSManaged public var ratingS: Int32
    @NSManaged public var review: NSSet?

}

// MARK: Generated accessors for review
extension ProductEntity {

    @objc(addReviewObject:)
    @NSManaged public func addToReview(_ value: ReviewEntity)

    @objc(removeReviewObject:)
    @NSManaged public func removeFromReview(_ value: ReviewEntity)

    @objc(addReview:)
    @NSManaged public func addToReview(_ values: NSSet)

    @objc(removeReview:)
    @NSManaged public func removeFromReview(_ values: NSSet)

}
