//
//  SettingsCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 7/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : customDarkGrayColor
            nameLabel.textColor = isHighlighted ? customRedColor : customWhitecolor
            imageView.tintColor = isHighlighted ? customRedColor : customWhitecolor
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            if let image = setting?.imageName {
                imageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = customWhitecolor
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel(color: customWhitecolor, fontName: "Avenir-Book", fontSize: 13)
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "settings")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(nameLabel)
        addSubview(imageView)
        
        addConstraintsWithFormaat(format: "H:|-16-[v0(20)]-16-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormaat(format: "V:[v0(20)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
