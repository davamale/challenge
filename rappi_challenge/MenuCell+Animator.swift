//
//  MenuCell+Animator.swift
//  rappi_challenge
//
//  Created by Dava on 2/12/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

extension MenuCell {
    
    /**
     Animates UICollectionViewCell to the provided frame.
     
     - Parameter collectionView: where cell is registered.
     - Parameter toFrame: final frame to animate.
     - Parameter completion: notifies the sender that the animation finished.
     
     */
    func animate(inCollectionView collectionView: UICollectionView, toLocation: CGPoint, withCompletion completion:((Bool) -> Void)? = nil) {
        
        // get indexpath
        guard let indexPath = collectionView.indexPath(for: self), let superview = collectionView.superview, let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        
        let attributesFrame = attributes?.frame
        
        let frameOnSuperView = collectionView.convert(attributesFrame!, to: superview)
        
        // creates cell snapshot
        let cellSnapShot = self.snapshotView(afterScreenUpdates: false)!
        cellSnapShot.frame = frameOnSuperView
        
        // creates layer view to be on the background while animating
        let layerView = UIView(frame: superview.frame)
        layerView.backgroundColor = .black
        layerView.alpha = 0.6
        
        window.addSubview(layerView)
        window.addSubview(cellSnapShot)
        
        // performs animation
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
            cellSnapShot.frame.origin = toLocation
        }) { (finished) in
            layerView.removeFromSuperview()
            cellSnapShot.removeFromSuperview()
            completion?(finished)
        }
    }
    
    /**
     Animates UICollectionViewCell to the provided frame.
     
     - Parameter collectionView: where cell is registered.
     - Parameter toFrame: final frame to animate.
     - Parameter completion: notifies the sender that the animation finished.
     
     */
    func animateLabel(inCollectionView collectionView: UICollectionView, toLocation: CGPoint, withCompletion completion:((Bool) -> Void)? = nil) {
        
        // get indexpath
        guard let indexPath = collectionView.indexPath(for: self), let superview = collectionView.superview, let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        
        let attributesFrame = attributes?.frame
        
        let frameOnSuperView = collectionView.convert(attributesFrame!, to: superview)
        
        // creates cell snapshot
        let cellSnapShot = categoryNameLabel.snapshotView(afterScreenUpdates: true)!
        cellSnapShot.frame = frameOnSuperView
        
        // creates layer view to be on the background while animating
        let layerView = UIView(frame: superview.frame)
        layerView.backgroundColor = .black
        layerView.alpha = 0.6
        
        window.addSubview(layerView)
        window.addSubview(cellSnapShot)
        
        // performs animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
            cellSnapShot.frame.origin = toLocation
        }) { (finished) in
            layerView.removeFromSuperview()
            cellSnapShot.removeFromSuperview()
            completion?(finished)
        }
    }
    
}
