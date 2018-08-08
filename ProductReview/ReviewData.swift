//
//  Rating.swift
//  ProductReview
//
//  Created by Pisit Lolak on 13/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import Foundation

class ReviewData {
    var rating: ratingStatus
    var name: String
    var date: String
    var description: String
    
    init(name: String,rating: String,date: String, description: String){
        self.name = name
        self.rating = ratingStatus(rawValue: rating)!
        self.date = date
        self.description = description
    }
    enum ratingStatus:String {
        case Sad
        case Fair
        case Like
    }
}
