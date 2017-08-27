//
//  NewsController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 27/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class NewsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.newsController = self
        return launcher
    }()
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //customizeNavController()
        collectionView?.backgroundColor = .white
        collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        customizeNavController()
        
        setupMenuBar()
        
        setupNavigationButtons()
    }
    
    private func setupNavigationButtons() {
        let moreImage = UIImage(named: "more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButtonItem]
    }
    
    func handleMore() {
        settingsLauncher.showSettings()
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        // view to hide the bug's effect when we swipe up
        let redView = UIView()
        redView.backgroundColor = customRedColor
        view.addSubview(redView)
        view.addConstraintsWithFormaat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormaat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormaat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormaat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 200)
    }
}
