//
//  Product.swift
//  ProductReview
//
//  Created by Pisit Lolak on 6/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import UIKit

class Product : NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(price, forKey: PropertyKey.price)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(highestRating, forKey: PropertyKey.highestRating)
        aCoder.encode(ratingS, forKey: PropertyKey.ratingS)
        aCoder.encode(ratingF, forKey: PropertyKey.ratingF)
        aCoder.encode(ratingL, forKey: PropertyKey.ratingL)
        aCoder.encode(ratingEmoticon, forKey: PropertyKey.ratingEmoticon)
        aCoder.encode(productDescription, forKey: PropertyKey.productDescription)
        aCoder.encode(reviews, forKey: PropertyKey.reviews)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let price = aDecoder.decodeObject(forKey: PropertyKey.price) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let ratingS = aDecoder.decodeInteger(forKey: PropertyKey.ratingS)
        let ratingF = aDecoder.decodeInteger(forKey: PropertyKey.ratingF)
        let ratingL = aDecoder.decodeInteger(forKey: PropertyKey.ratingL)
        let productDescription = aDecoder.decodeObject(forKey: PropertyKey.productDescription) as? String
        let reviews = aDecoder.decodeObject(forKey: PropertyKey.reviews) as? [ReviewData]
        self.init(name: name!, price: price!, photo: photo, ratingS: ratingS, ratingF: ratingF, ratingL: ratingL, description: productDescription!, ratings: reviews)
    }
    
    
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
    struct PropertyKey{
        static let name = "name"
        static let price = "price"
        static let photo = "photo"
        static let rating = "rating"
        static let highestRating = "highestRating"
        static let ratingS = "ratingS"
        static let ratingF = "ratingF"
        static let ratingL = "ratingL"
        static let ratingEmoticon = "ratingEmoticon"
        static let productDescription = "productDescription"
        static let reviews = "reviews"
    }
    
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
