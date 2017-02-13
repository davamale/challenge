//
//  MenuVC.swift
//  rappi_challenge
//
//  Created by Dava on 2/7/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit
import AlamofireImage

class MenuVC: UIViewController {
    
    /// UICollectionViewLayout for portrait mode
    fileprivate var portraitFlowLayout: UICollectionViewLayout = {
    
        let pfl = UICollectionViewFlowLayout()
        pfl.itemSize = CGSize(width: 145, height: 50)
        pfl.minimumLineSpacing = 10
        
        return pfl
    }()
    
    /// UICollectionViewLayout for landscape mode
    fileprivate lazy var landscapeFlowLayout: UICollectionViewLayout = {
        
        let pfl = UICollectionViewFlowLayout()
        pfl.estimatedItemSize = CGSize(width: self.view.frame.width, height: 50)
        
        return pfl
    }()
    
    /// Collection view
    fileprivate lazy var collectionView: UICollectionView = {
       
        // sets flow layout depending on the device orientation
        let cv = UICollectionView(frame: self.view.frame, collectionViewLayout: UIDevice.isPortrait ? self.portraitFlowLayout : self.landscapeFlowLayout)
        cv.register(MenuCell.nib(), forCellWithReuseIdentifier: MenuCell.identifier)
        cv.backgroundColor = .customLightGray
        
        return cv
    }()
    
    /// Menu's view model
    fileprivate lazy var modelView: MenuViewModel = {
        let mv = MenuViewModel(withDelegate: self)
        
        return mv
    }()
    
    let presentatioTransition = PresentationTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        modelView.initialLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //TODO: Move this to delegate method
        // Create our custom flow layout that evenly space out the items, and have them in the center
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 145, height: 50)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        
        // Find n, where n is the number of item that can fit into the collection view
        var n: CGFloat = 1
        let containerWidth = collectionView.bounds.width
        while true {
            let nextN = n + 1
            let totalWidth = (nextN*145) + (nextN-1)*10
            if totalWidth > containerWidth {
                break
            } else {
                n = nextN
            }
        }
        
        // Calculate the section inset for left and right.
        // Setting this section inset will manipulate the items such that they will all be aligned horizontally center.
        let inset = max(10, floor( (containerWidth - (n*145) - (n-1)*10) / 2 ) )
        layout.sectionInset = UIEdgeInsets(top: 10, left: inset, bottom: 10, right: inset)
        
        collectionView.collectionViewLayout = layout
    }
    
    /**
     Handle view transition to the app list for the selected category.
     */
    fileprivate func transitionToAppsList(forCategory category: Category) {
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        
        guard let navController = UIStoryboard.app.instantiateInitialViewController() as? UINavigationController, let appViewController = navController.topViewController as? AppsVC else {
            return
        }
        
        appViewController.navigationItem.title = category.name
        
        present(navController, animated: true, completion: nil)
    }
}

//MARK: MenuViewModel Delegate
extension MenuVC: MenuViewModelDelegate {
    func shouldReloadCollectionView() {
        collectionView.reloadData()
    }
}

extension MenuVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentatioTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}

//MARK: ViewController Protocol
extension MenuVC: ViewControllerProtocol {
    func prepareUI() {
        view.backgroundColor = .customLightGray
        view.addSubview(collectionView)
        navigationController?.navigationBar.isTranslucent = false
    }
}

//MARK: UICollectionView DataSource
extension MenuVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelView.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        
        guard let category = modelView.category(atIndexPath: indexPath) else {
            return cell
        }
        
        return cell.populate(withObject: category)
    }
}

//MARK: UICollectionView Delegate
extension MenuVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let originalCell = collectionView.cellForItem(at: indexPath) as! MenuCell
        
        // animates cell
        originalCell.animateLabel(inCollectionView: collectionView, toLocation: CGPoint(x: (view.frame.width/2) - (originalCell.frame.width/2), y: (64/2) - (originalCell.frame.height/2)), withCompletion: { (finished) in
            
            if finished {
                self.navigationItem.title = originalCell.categoryNameLabel.text
                self.transitionToAppsList(forCategory: originalCell.category)
            }
        })
    }
}















