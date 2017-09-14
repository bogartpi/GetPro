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
        iv.backgroundColor = UIColor.customDarkGrayColor
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel(color: UIColor.white, fontName: "Avenir-Heavy", fontSize: 25, align: NSTextAlignment.center)
        label.text = "Username"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        
        profileImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
