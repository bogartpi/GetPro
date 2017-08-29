//
//  MainTabBarController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 29/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = customRedColor
        
        // News Controller
        let newsLayout = UICollectionViewFlowLayout()
        newsLayout.minimumLineSpacing = 1
        let newsController = NewsController(collectionViewLayout: newsLayout)
        let newsNavController = UINavigationController(rootViewController: newsController)
        newsNavController.tabBarItem.image = #imageLiteral(resourceName: "newsBlack").withRenderingMode(.alwaysOriginal)
        newsNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "newsWhite").withRenderingMode(.alwaysOriginal)
        
        // Rosters Controller
        let teamsLayout = UICollectionViewFlowLayout()
        let teamsController = TeamsController(collectionViewLayout: teamsLayout)
        let teamsNavController = UINavigationController(rootViewController: teamsController)
        teamsNavController.tabBarItem.image = #imageLiteral(resourceName: "rostersBlack").withRenderingMode(.alwaysOriginal)
        teamsNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "rostersWhite").withRenderingMode(.alwaysOriginal)
        
        // Profile Controller
        let profileController = ProfileController(nibName: nil, bundle: nil)
        let profileNavController = UINavigationController(rootViewController: profileController)
        profileNavController.tabBarItem.image = #imageLiteral(resourceName: "profileBlack").withRenderingMode(.alwaysOriginal)
        profileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profileWhite").withRenderingMode(.alwaysOriginal)
        
        viewControllers = [newsNavController, teamsNavController, profileNavController]
    }
    
}
