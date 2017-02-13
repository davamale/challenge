//
//  AppDelegate.swift
//  rappi_challenge
//
//  Created by Dava on 2/7/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // customize UI
        prepareUI()
        
        return true
    }
    
    fileprivate func prepareUI() {
        UINavigationBar.appearance().tintColor = .customBlue
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.customBlue, NSFontAttributeName: UIFont.systemFont(ofSize: 17)]
    }
}

