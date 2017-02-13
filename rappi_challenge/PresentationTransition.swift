//
//  PresentationTransition.swift
//  rappi_challenge
//
//  Created by Dava on 2/12/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

class PresentationTransition: NSObject {}


extension PresentationTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        let finalFrameForVC = fromViewController.view.frame
        
        toViewController.view.alpha = 0.0
        
        // will start with a height of 0
        toViewController.view.frame = CGRect(x: finalFrameForVC.origin.x, y: finalFrameForVC.origin.y, width: finalFrameForVC.width, height: 0)
        
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            
            toViewController.view.alpha = 1.0
            toViewController.view.frame = finalFrameForVC
            
        }, completion: { finished in
            transitionContext.completeTransition(true)
            
        })
        
    }
    
}






