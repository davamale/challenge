//
//  UIDevice+Custom.swift
//  rappi_challenge
//
//  Created by Dava on 2/7/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

extension UIDevice {
    
    /// Verifies if current device is an iPad and returns true if it's.
    static var isPad: Bool {
        return current.userInterfaceIdiom == .pad
    }
    
    /// Returns true if current device is in portrait mode.
    static var isPortrait: Bool {
        return current.orientation == .portrait
    }
}
