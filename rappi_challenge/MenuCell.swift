//
//  MenuCell.swift
//  rappi_challenge
//
//  Created by Dava on 2/8/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit
import CoreData

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    var category: Category!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareUI()
    }

}


extension MenuCell: CollectionViewCellProtocol {
    
    func prepareUI() {
        backgroundColor = .customLightGray
        categoryNameLabel.textColor = .customBlue
        bottomView.backgroundColor = .customRed
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MenuCell", bundle: nil)
    }
    
    func populate<Object: NSManagedObject>(withObject object: Object) -> Self {
        
        guard let cat = object as? Category else {
            return self
        }
        
        category = cat
        categoryNameLabel.text = category.name
        
        return self
    }
}









