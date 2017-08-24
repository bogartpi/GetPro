//
//  ScreenshotCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 5/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ScreenshotsCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private let screenshotCellId = "cellId"

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        
        addConstraintsWithFormaat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(ScreenshotsImageCell.self, forCellWithReuseIdentifier: screenshotCellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private class ScreenshotsImageCell: UICollectionViewCell {
        
        var imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = customDarkGrayColor
            iv.layer.masksToBounds = true
            iv.isUserInteractionEnabled = true
            return iv
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(imageView)
            addConstraintsWithFormaat(format: "H:|[v0]|", views: imageView)
            addConstraintsWithFormaat(format: "V:|[v0]|", views: imageView)
            setDefaultShadow()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
