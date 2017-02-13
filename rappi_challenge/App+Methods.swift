//
//  App+Methods.swift
//  rappi_challenge
//
//  Created by Dava on 2/9/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import Foundation
import CoreData

//MARK: ManagedObjectType Protocol
extension App: ManagedObjectType {
    
    /// Manage Object Entity name
    public static var entityName: String {
        return "App"
    }
    
    public static var defaultSortDescriptors:[NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}


//MARK: ManagedObjectMethods Protocol
extension App: ManagedObjectMethods {

    public static func fetch(categoryWithId id: String) -> Category? {
        return nil
    }

    
    public typealias ModelObject = App
    
    public static func save(object: NSDictionary?) -> ModelObject? {
        
        guard let object = object else {
            return nil
        }
        
        
        guard let app = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: CoreDataStack.shared.context) as? App else {
            return nil
        }
        
        // unwrap category name
        if let imName = object["im:name"] as? JSON, let name = imName["label"] as? String {
            app.name = name
        }
        
        if let imageArray = object["im:image"] as? [JSON], imageArray.count > 0 {
            
            let smallImageObject = imageArray[0]
            
            if let smallImage = smallImageObject["label"] as? String {
                app.stringUrlThumbnail = smallImage
            }
            
            let bigImageObject = imageArray[2]
            
            if let bigImage = bigImageObject["label"] as? String {
                app.stringUrlImage = bigImage
            }
        }
        
        // unwrap category name
        if let categoryObject = object["category"] as? JSON {
            app.category = Category.save(object: categoryObject)
        }
        
        return app
    }
    
}
