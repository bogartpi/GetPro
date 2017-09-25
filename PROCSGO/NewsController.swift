//
//  NewsController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 27/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class NewsController: UICollectionViewController {
    
    fileprivate let cellId = "cellId"
    fileprivate var addButtonItem: UIBarButtonItem!
    fileprivate var warningView: WarningView!
    fileprivate var postsArray = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.customDarkGrayColor
        collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        checkAdminAccess()
        setupView()
        fetchOrderedPosts()
    }
    
    @objc fileprivate func handleRefresh() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.checkReachability), userInfo: nil, repeats: false)
        fetchOrderedPosts()
        if postsArray.count == 0 {
            DispatchQueue.main.async {
                self.collectionView?.refreshControl?.endRefreshing()
                self.collectionView?.reloadData()
            }
        }
    }
    
    @objc fileprivate func checkReachability() {
        if currentReachabilityStatus == .reachableViaWiFi {
            print("connected")
        } else if currentReachabilityStatus == .reachableViaWWAN {
            print("connected wwan")
        } else {
            print("not connected")
            DispatchQueue.main.async {
                self.collectionView?.refreshControl?.endRefreshing()
                self.collectionView?.reloadData()
            }
            self.setupWarningView()
        }
    }
    
    fileprivate func fetchOrderedPosts() {
        let postRef = Database.database().reference().child("posts")
        postRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.postsArray.removeAll(keepingCapacity: false)
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                var post = Post(dictionary: dictionary)
                post.id = key
                
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
        if Auth.auth().currentUser?.email == "bogartpimail@gmail.com" {
            let addImage = UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
            addButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(handleGoToNews))
            navigationItem.leftBarButtonItems = [addButtonItem]
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
}

// MARK: - Handle Presenting Controllers

extension NewsController {
    @objc fileprivate func handleGoToNews() {
        let postController = PostController()
        let navController = UINavigationController(rootViewController: postController)
        self.present(navController, animated: true)
    }
    
    func showNewsDetailController(index: Int) {
        let layout = UICollectionViewFlowLayout()
        let detailVC = NewsDetailController(collectionViewLayout: layout)
        print("TEST",postsArray[0])
        detailVC.post = postsArray[index]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - View Methods

extension NewsController {    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.checkReachability), userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            self.collectionView?.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - Setting View Layers

extension NewsController {
    
    func setupView() {
        navigationItem.title = "News"
        changeNavigationTintColor(.white)
        customizeNavController()
    }
    
    func setupWarningView() {
        let warnView = WarningView(frame: CGRect(x: 0, y: -80, width: self.view.frame.width, height: 0))
        self.warningView = warnView
        view.addSubview(warningView)
    }
}

// MARK: - CollectionView Methods

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
        return CGSize(width: view.frame.size.width - 16, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showNewsDetailController(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
}
