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
    var productDescription: String
    var reviews: [ReviewData]?
    
    init(name:String, price:String, photo:UIImage?, ratingS: Int, ratingF: Int, ratingL: Int, description: String,ratings: [ReviewData]?){
        self.name = name
        self.price = price
        self.photo = photo
        self.ratingS = ratingS
        self.ratingF = ratingF
        self.ratingL = ratingL
        self.rating = Rating(sad: ratingS, fair: ratingF, like: ratingL)
        self.productDescription = description
        self.reviews = ratings
        if ratingL == 0 && ratingF == 0 && ratingS == 0{
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonFair")
            highestRating = ratingF
        }
        else if ratingL >= ratingF && ratingL >= ratingS{
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonLike")
            highestRating = ratingL
        }
        else if ratingF >= ratingL && ratingF >= ratingS {
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonFair")
            highestRating = ratingF
        }
        else {
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonSad")
            highestRating = ratingS
        }
    }
    func addReview(review: ReviewData){
        reviews?.append(review)
        switch review.rating{
        case .Sad:
            self.ratingS = self.ratingS + 1
        case .Fair:
            self.ratingF = self.ratingF + 1
        case .Like:
            self.ratingL = self.ratingL + 1
        }
        checkHighest()
    }
    func checkHighest(){
        if ratingL == 0 && ratingF == 0 && ratingS == 0{
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonFair")
            highestRating = ratingF
        }
        else if ratingL >= ratingF && ratingL >= ratingS{
            self.ratingEmoticon = #imageLiteral(resourceName: "emoticonLike")
            highestRating = ratingL
        }
        else if ratingF >= ratingL && ratingF >= ratingS {
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
