//
//  ProfileController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 29/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = customGrayColor
        customizeNavController()
        navigationItem.title = "Profile"
        changeNavigationTintColor(.white)
    }
    
}
