//
//  Product.swift
//  ProductReview
//
//  Created by Pisit Lolak on 6/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit

class Product {
    
    //MARK: Property
    var name: String
    var price: String
    var photo: UIImage?
    var rating: Rating
    var highestRating:Int
    var ratingS: Int
    var ratingF: Int
    var ratingL:Int
    var ratingEmoticon: UIImage?
    var review: String
    var description: String
    
    init(name:String, price:String, photo:UIImage?, ratingS: Int, ratingF: Int, ratingL: Int, review: String, description: String){
        self.name = name
        self.price = price
        self.photo = photo
        self.ratingS = ratingS
        self.ratingF = ratingF
        self.ratingL = ratingL
        self.review = review
        self.rating = Rating(sad: ratingS, fair: ratingF, like: ratingL)
        self.description = description
        if ratingL > ratingF && ratingL > ratingS{
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonLike")
            highestRating = ratingL
        }
        else if ratingF > ratingL && ratingF > ratingS {
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonFair")
            highestRating = ratingF
        }
        else {
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonSad")
            highestRating = ratingS
        }
    }
    public struct Rating {
        var sad: Int
        var fair: Int
        var like: Int
    }
}
