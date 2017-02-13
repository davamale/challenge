//
//  NetworkManager.swift
//  rappi_challenge
//
//  Created by Dava on 2/7/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit
import Alamofire

/// alias NSDictionary to JSON
public typealias JSON = NSDictionary

class NetworkManager: NSObject {
    
    /// Class method to get apps json.
    static func get(completion: @escaping (JSON) -> ()) {
        Alamofire.request(Constants.baseURL).responseJSON { (responseObject) in
            guard let reponseJson = responseObject.result.value as? JSON else {
                return
            }
            completion(reponseJson)
        }
    }
}









