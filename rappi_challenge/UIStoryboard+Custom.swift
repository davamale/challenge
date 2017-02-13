//
//  UIStoryboard+Custom.swift
//  rappi_challenge
//
//  Created by Dava on 2/12/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Main storyboard
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    /// App storyboard
    static var app: UIStoryboard {
        return UIStoryboard(name: "App", bundle: nil)
    }
    
}
