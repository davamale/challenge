//
//  AppsVC.swift
//  rappi_challenge
//
//  Created by Dava on 2/12/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

class AppsVC: UIViewController {
    
    var category: Category!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }

}



extension AppsVC: ViewControllerProtocol {
    
}
