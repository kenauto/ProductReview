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
    var rating: Int
    var ratingEmoticon: UIImage?
    var review: String
    
    init(name:String, price:String, photo:UIImage?, rating: Int, ratingEmoticon: UIImage?, review: String){
        self.name = name
        self.price = price
        self.photo = photo
        self.rating = rating
        self.ratingEmoticon = ratingEmoticon
        self.review = review
    }
}
