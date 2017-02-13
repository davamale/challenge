//
//  AppsVC.swift
//  rappi_challenge
//
//  Created by Dava on 2/12/17.
//  Copyright © 2017 Davaur. All rights reserved.
//

import UIKit

class AppsVC: UIViewController {
    
    // category object
    var category: Category!
    
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
        
        //TODO: Implement cell class
        cv.register(MenuCell.nib(), forCellWithReuseIdentifier: MenuCell.identifier)
        cv.backgroundColor = .customLightGray
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    //MARK: Private
    internal func close() {
        dismiss(animated: true, completion: nil)
    }

}


//MARK: ViewController Protocol
extension AppsVC: ViewControllerProtocol {
    func prepareUI() {
        
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        navigationItem.leftBarButtonItem = closeButton
        navigationController?.navigationBar.isTranslucent = false
        view.addSubview(collectionView)
    }
}
