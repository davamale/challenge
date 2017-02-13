//
//  ViewControllerProtocol.swift
//  rappi_challenge
//
//  Created by Dava on 2/7/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

/// Must be adopted by all UIViewController sub-classes.
protocol ViewControllerProtocol: class {
    
    /// Should be called for UIViewController sub-class customization.
    func prepareUI()
}

/// UIViewControllerProtocol default implementation
extension ViewControllerProtocol where Self: UIViewController {
    
    func prepareUI() {
        self.view.backgroundColor = .customLightGray
    }
    
}
