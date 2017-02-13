//
//  MenuViewModel.swift
//  rappi_challenge
//
//  Created by Dava on 2/7/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit
import CoreData

///
protocol MenuViewModelDelegate: class {
    func shouldReloadCollectionView()
}

final class MenuViewModel: NSObject {

    /// Menu view model delegate
    fileprivate var delegate: MenuViewModelDelegate!
    fileprivate var categories: [Category]?
    
    init(withDelegate delegate: MenuViewModelDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    //MARK: Public Methods
    public func initialLoad() {
        httpGet()
    }
    
    public func numberOfItems(inSection section: Int) -> Int {
        return categories != nil ? categories!.count : 0
    }
    
    public func category(atIndexPath indexPath: IndexPath) -> Category? {
        return categories?[indexPath.row]
    }
    
    //MARK: Private Methods
    //MARK: Network Methods
    /**
     Makes HTTP GET to get all apps info.
     */
    fileprivate func httpGet() {
        NetworkManager.get(completion: { (response) in
            self.saveResponse(response: response)
        })
    }
    
    //MARK: Model Methods
    
    /**
     Saves the response to each model.
     
     - parameter response JSON object containing all the data to be stored.
     */
    fileprivate func saveResponse(response: JSON) {
        
        guard let feed = response["feed"] as? JSON, let entries = feed["entry"] as? [JSON] else {
            return
        }
        
        for entry in entries {
            let _ = App.save(object: entry)
        }
        
        categories = Category.fetchAll()
        delegate.shouldReloadCollectionView()
    }
    
}










