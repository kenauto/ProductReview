//
//  CoreDataManager.swift
//  ProductReview
//
//  Created by Pisit Lolak on 7/8/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataManager  {
    static func saveProductToPersistData(datas: [Product]) {
        resetProductData()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)!
        
        for data in datas {
            let product = ProductEntity(entity: entity, insertInto: context)
            product.values = data
        }
        
        do {
            try context.save()
            
        } catch let error as NSError {
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func fetchProductData() -> [ProductEntity] {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                fatalError()
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<ProductEntity>(entityName: "Product")
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            fatalError("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func resetProductData(){
        // create the delete request for the specified entity
        let fetchRequest = NSFetchRequest<ProductEntity>(entityName: "Product")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        // get reference to the persistent container
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
