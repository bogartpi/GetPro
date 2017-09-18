//
//  HeaderCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 8/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class ProfileHeaderView: UICollectionViewCell {
    
    var user: User? {
        didSet {
            guard let profileImageUrl = user?.profileImageUrl else { return }
            profileImageView.loadImage(urlString: profileImageUrl)
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.customGrayColor
        iv.layer.cornerRadius = 35
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel(color: UIColor.white, fontName: "Avenir-Heavy", fontSize: 20, align: NSTextAlignment.left)
        label.backgroundColor = UIColor.customGrayColor
        label.text = ""
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = UIColor.customDarkGrayColor
    }
    
    func setup() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil,
                                right: nil, paddingTop: 15, paddingLeft: 20,
                                paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        usernameLabel.anchor(top: nil, left: profileImageView.rightAnchor,
                             bottom: nil, right: rightAnchor, paddingTop: 0,
                             paddingLeft: 20, paddingBottom: 0, paddingRight: 20, height: 30)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
