//
//  CoreDataProtocol.swift
//  rappi_challenge
//
//  Created by Dava on 2/8/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import CoreData

// MARK: ManageObject Protocol
public protocol ManagedObjectType: class {
    
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}


extension ManagedObjectType {
    
    public static var defaultSortDescriptors:[NSSortDescriptor] {
        return[]
    }
    
    public static var sortedFetchRequest: NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}

public typealias Predicate = [String : AnyObject]

// MARK: Methods Protocol
public protocol ManagedObjectMethods: class {
    
    associatedtype ModelObject
    
    /**
     Saves json into core data.
     
     - Parameter objects: key value pair to store.
     
     - Returns: generic type <Object: NSManagedObject>
     */
    static func save(object: NSDictionary?) -> ModelObject?
    
    /**
     Fetch all objects for the Entity type and returns them.
     
     - Returns: [Entity]? an optional array of Entity objects
     */
    static func fetchAll<Entity: NSManagedObject>() -> [Entity]?
    
    /**
     Fetch objects by identifier
     
     - Parameter value: to be fetched.
     - Parameter key: is the variable that should hold the value.
     
     - Returns: Entity? optional Entity objects
     */
    static func fetch<Entity: NSManagedObject>(uniqueValue value: String, forKey key: String) -> Entity?
}

//MARK: ManagedObjectMethods Default Implementation
extension ManagedObjectMethods where Self: ManagedObjectType {
    
    public static func fetchAll<Entity: NSManagedObject>() -> [Entity]? {
        
        let request = Entity.fetchRequest()
        
        guard let fetchedObjects = try? CoreDataStack.shared.context.fetch(request) as? [Entity], fetchedObjects!.count > 0 else {
            return nil
        }
 
        return  fetchedObjects
    }
    
    public static func fetch<Entity: NSManagedObject>(uniqueValue value: String, forKey key: String) -> Entity? {
        let cdStack = CoreDataStack.shared
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = NSPredicate(format: "%K = %@", key, value)
        
        let fetchResult = (try? cdStack.context.fetch(request)) as? [Entity]
        
        if let results = fetchResult {
            if !results.isEmpty && results.count > 0 {
                return results[0]
            }
        }
        return nil
    }
}










