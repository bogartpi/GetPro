//
//  NewsController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 27/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

private let cellId = "cellId"

class NewsController: UICollectionViewController {
    
    var addButtonItem: UIBarButtonItem!
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.newsController = self
        return launcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkAdminAccess()
        setupRightNavButton()
        navigationItem.title = "News"
        changeNavigationTintColor(.white)
        customizeNavController()
        collectionView?.backgroundColor = UIColor.customDarkGrayColor
        collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func checkAdminAccess() {
        if Auth.auth().currentUser?.email == "test1@mail.com" {
            let addImage = UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
            addButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(handleAddPhoto))
            navigationItem.leftBarButtonItems = [addButtonItem]
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }

    private func setupRightNavButton() {
        let moreImage = UIImage(named: "more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButtonItem]
    }
    
    func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func handleAddPhoto() {
        let postController = PostController()
        let navController = UINavigationController(rootViewController: postController)
        self.present(navController, animated: true)
    }
}

extension NewsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 16, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = NewsDetailController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
}
