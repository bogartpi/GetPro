//
//  ScreenshotCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 5/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

private let screenshotCellId = "cellId"

class ScreenshotsCell: BaseCell {

    var info: Info? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        setup()
    }
    
    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        addConstraintsWithFormaat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(ScreenshotsImageCell.self, forCellWithReuseIdentifier: screenshotCellId)
    }
}

private class ScreenshotsImageCell: BaseCell {
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = customDarkGrayColor
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        setup()
    }
    
    func setup() {
        addSubview(imageView)
        addConstraintsWithFormaat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: imageView)
        setDefaultShadow()
    }
}

extension ScreenshotsCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = info?.screenshots?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotCellId, for: indexPath) as! ScreenshotsImageCell
        if let imageName = info?.screenshots?[indexPath.item] {
            cell.imageView.image = UIImage(named: imageName)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 290, height: frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
}
