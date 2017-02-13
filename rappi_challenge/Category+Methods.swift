//
//  Category+Methods.swift
//  rappi_challenge
//
//  Created by Dava on 2/8/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import Foundation
import CoreData

//MARK: ManagedObjectType Protocol
extension Category: ManagedObjectType {
    
    /// Manage Object entity name
    public static var entityName: String {
        return "Category"
    }
    
    /// Sort descriptor for entity
    public static var defaultSortDescriptors: NSSortDescriptor {
        return NSSortDescriptor(key: "name", ascending: true)
    }
}


//MARK: ManagedObjectMethods Protocol
extension Category: ManagedObjectMethods {
    
    public typealias ModelObject = Category
    
    public static func save(object: NSDictionary?) -> ModelObject? {
        
        guard let object = object else {
            return nil
        }
        
        guard let attribute = object["attributes"] as? JSON, let id = attribute["label"] as? String else {
            return nil
        }
        
        // if the category already exists, returns it
        if let fetchedCategory: Category = fetch(uniqueValue: id, forKey: "name") {
            return fetchedCategory
        }
        
        // creates new Category
        let category: Category = CoreDataStack.shared.context.insertObject()
        
        category.id = id
        
        // unwrap category name
        if let name = attribute["label"] as? String {
            category.name = name
        }

        
        return category
    }
}









