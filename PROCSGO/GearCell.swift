//
//  GearCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 5/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class GearCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var gearInfo: Info? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var imagesArray = ["monitor", "mouse", "mousepad", "keyboard", "headset"]
    
    private var internalGearCellId = "internalGearCellId"
    
    // header
    
    let headerLabel: UILabel = {
        let label = UILabel(font: UIFont.boldSystemFont(ofSize: 15), color: customRedColor)
        label.text = "GEAR"
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(InternalGearsCell.self, forCellWithReuseIdentifier: internalGearCellId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(headerLabel)
        addSubview(collectionView)
        
        addConstraintsWithFormaat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormaat(format: "V:|-32-[v0]-16-|", views: collectionView)
    
        headerLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: internalGearCellId, for: indexPath) as! InternalGearsCell
        cell.imageView.image = UIImage(named: imagesArray[indexPath.item])
        cell.gearLabel.text = gearInfo?.gears?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 14 - 32, height: 40)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class InternalGearsCell: UICollectionViewCell {
        
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.layer.masksToBounds = true
            iv.isUserInteractionEnabled = true
            return iv
        }()
        
        let gearLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Avenir-Heavy", size: 14)
            label.text = "XTRFY EK-8904"
            label.textColor = customWhitecolor
            label.minimumScaleFactor = 0.2
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = customDarkGrayColor
            self.layer.cornerRadius = 3
            self.layer.masksToBounds = true
            
            addSubview(imageView)
            addSubview(gearLabel)
            
            imageView.anchor(top: nil, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            
            gearLabel.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 7, width: 0, height: 25)
            gearLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            
            setDefaultShadow()
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}