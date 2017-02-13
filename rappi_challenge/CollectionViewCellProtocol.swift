//
//  CollectionViewCellProtocol.swift
//  rappi_challenge
//
//  Created by Dava on 2/8/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit
import CoreData

protocol CollectionViewCellProtocol {
    
    /// Cell identifier
    static var identifier: String { get }
    
    static func nib() -> UINib
    
    /// Customize UI
    func prepareUI()
    
    /// Method to used to pupolte self
    func populate<Object: NSManagedObject>(withObject object: Object) -> Self
}

//MARK: CollectionViewCellProtocol Default Implementation
extension CollectionViewCellProtocol where Self: UICollectionViewCell {
    
    static var identifier: String {
        get {
            return "Cell"
        }
    }
    
    func prepareUI() {
        contentView.backgroundColor = .customLightGray
    }
    
}
