//
//  NSManagedObject+Methods.swift
//  rappi_challenge
//
//  Created by Dava on 2/11/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    public func insertObject<Entity: NSManagedObject> () -> Entity where Entity: ManagedObjectType {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: Entity.entityName, into: self) as? Entity else {
            fatalError("Wrong Object")
        }
        return obj
    }
    
    public func entityObject<Entity: NSManagedObject>() -> Entity where  Entity: ManagedObjectType {
        guard let obj = NSEntityDescription.entity(forEntityName: Entity.entityName, in: self) as? Entity else {
            fatalError("Wrong Object")
        }
        return obj
    }
    
}
