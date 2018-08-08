//
//  ReviewEntity+CoreDataClass.swift
//  
//
//  Created by Pisit Lolak on 7/8/2561 BE.
//
//

import Foundation
import CoreData

@objc(ReviewEntity)
public class ReviewEntity: NSManagedObject {
    var values : ReviewData{
        get {
            return ReviewData(name: self.name!, rating: self.ratings!, date: self.date!, description: self.reviewDescription!)
        }
        set {
            self.name = newValue.name
            self.date = newValue.date
            self.ratings = newValue.rating.rawValue
            self.reviewDescription = newValue.description
        }
    }
}
