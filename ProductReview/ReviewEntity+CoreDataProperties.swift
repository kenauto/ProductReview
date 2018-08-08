//
//  ReviewEntity+CoreDataProperties.swift
//  
//
//  Created by Pisit Lolak on 7/8/2561 BE.
//
//

import Foundation
import CoreData


extension ReviewEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewEntity> {
        return NSFetchRequest<ReviewEntity>(entityName: "ReviewEntity")
    }

    @NSManaged public var date: String?
    @NSManaged public var name: String?
    @NSManaged public var ratings: String?
    @NSManaged public var reviewDescription: String?
    @NSManaged public var product: ProductEntity?

}
