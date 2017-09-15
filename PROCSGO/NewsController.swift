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
    
    var postsArray = [Post]()
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.newsController = self
        return launcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkAdminAccess()
        setupView()
        collectionView?.backgroundColor = UIColor.customDarkGrayColor
        collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    
        fetchOrderedPosts()
    }
    
    func setupView() {
        setupRightNavButton()
        navigationItem.title = "News"
        changeNavigationTintColor(.white)
        customizeNavController()
    }
    
    func handleRefresh() {
        fetchOrderedPosts()
        if postsArray.count == 0 {
            DispatchQueue.main.async {
                self.collectionView?.refreshControl?.endRefreshing()
                self.collectionView?.reloadData()
            }
        }
    }
    
    fileprivate func fetchOrderedPosts() {
        let postRef = Database.database().reference().child("posts")
        postRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.postsArray.removeAll(keepingCapacity: false)
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                let post = Post(dictionary: dictionary)
                
                self.postsArray.insert(post, at: 0)
                self.postsArray.sort(by: { (p1, p2) -> Bool in
                    return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                })
            })
            DispatchQueue.main.async {
                self.collectionView?.refreshControl?.endRefreshing()
                self.collectionView?.reloadData()
            }
        }) { (err) in
            print("Failed to fetch news", err.localizedDescription)
        }
    }
    
    fileprivate func checkAdminAccess() {
        if Auth.auth().currentUser?.email == "test@mail.com" {
            let addImage = UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
            addButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(handleGoToNews))
            navigationItem.leftBarButtonItems = [addButtonItem]
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }

    fileprivate func setupRightNavButton() {
        let moreImage = UIImage(named: "more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButtonItem]
    }
    
    func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func handleGoToNews() {
        let postController = PostController()
        let navController = UINavigationController(rootViewController: postController)
        self.present(navController, animated: true)
    }
}

extension NewsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
        cell.post = postsArray[indexPath.item]
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
