//
//  MainTabBarController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 29/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LogInController()
                let navLoginVC = UINavigationController(rootViewController: loginVC)
                self.present(navLoginVC, animated: true, completion: nil)
            }
            return
        } 
        
        tabBar.barTintColor = UIColor.customRedColor
        setupViewControllers()
    }
    
    func setupViewControllers() {
        // News Controller
        let newsController = templateNavController(unselectedImage: #imageLiteral(resourceName: "newsBlack"), selectedImage: #imageLiteral(resourceName: "newsWhite"), rootController: NewsController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Rosters Controller
        let teamsController = templateNavController(unselectedImage: #imageLiteral(resourceName: "rostersBlack"), selectedImage: #imageLiteral(resourceName: "rostersWhite"), rootController: TeamsController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Profile Controller
        let profileController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profileBlack"), selectedImage: #imageLiteral(resourceName: "profileWhite"), rootController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))

        viewControllers = [newsController, teamsController, profileController]
        
        // Modify TabBar Items Insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        }
    }
    
}

extension UITabBarController {
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        return navController
    }
}
