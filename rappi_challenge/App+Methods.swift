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

    public typealias ModelObject = App
    
    public static func save(object: NSDictionary?) -> ModelObject? {
        
        guard let object = object, let imName = object["im:name"] as? JSON, let name = imName["label"] as? String, let idObject = object["id"] as? JSON, let attr = idObject["attributes"] as? JSON, let id = attr["im:id"] as? String else {
            return nil
        }
        
        // if app already exists, return
        if let app = fetch(uniqueValue: id, forKey: "id") as? App {
            return app
        }
        
        let app: App = CoreDataStack.shared.context.insertObject()
        
        app.name = name
        app.id = id
        
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
