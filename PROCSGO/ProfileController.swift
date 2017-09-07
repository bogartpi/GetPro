//
//  ProfileController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 29/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    fileprivate var profileCellId = "profileCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.customDarkGrayColor
        customizeNavController()
        navigationItem.title = "Profile"
        changeNavigationTintColor(.white)
    }
    
}
