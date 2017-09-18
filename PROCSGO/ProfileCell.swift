//
//  ProfileCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 7/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ProfileCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.customDarkGrayColor
            nameLabel.textColor = isHighlighted ? UIColor.customRedColor : UIColor.customWhitecolor
            imageView.tintColor = isHighlighted ? UIColor.customRedColor : UIColor.customWhitecolor
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            if let image = setting?.imageName {
                imageView.image = UIImage(named: image.rawValue)?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = UIColor.customWhitecolor
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel(color: UIColor.customWhitecolor, fontName: "Avenir-Book", fontSize: 13)
        label.text = "Setting"
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "settings")
        return iv
    }()
    
    let disclosureImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named: "disclosure")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        setup()
        backgroundColor = UIColor.customDarkGrayColor
    }
    
    func setup() {
        addSubview(nameLabel)
        addSubview(imageView)
        addSubview(disclosureImageView)
        
        addConstraintsWithFormaat(format: "H:|-16-[v0(17)]-16-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormaat(format: "V:[v0(17)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        disclosureImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 12, height: 12)
        disclosureImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}

