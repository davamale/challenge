//
//  DismisserTransition.swift
//  rappi_challenge
//
//  Created by Dava on 2/12/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

class DismisserTransition: NSObject {}

extension DismisserTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
}


