//
//  CommentsCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 17/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CommentsCell: BaseCell {
    
    var comment: Comment? {
        didSet {
            guard let comment = comment else { return }
 
            profileImageView.loadImage(urlString: comment.user.profileImageUrl)
            
            let usernameAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.customDarkGrayColor,
                                              NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 15)!]
            let attributedUsername = NSMutableAttributedString(string: comment.user.username, attributes: usernameAttributes)
            let commentAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.customGrayColor,
                                                      NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 14)!]
            let attributedString = NSMutableAttributedString(string: "  " + comment.text, attributes: commentAttributes)
            attributedUsername.append(attributedString)
            textView.attributedText = attributedUsername
        }
    }
    
    override func setupViews() {
        super.setupViews()
        setup()
    }
    
    func setup() {
        addSubview(textView)
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        textView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.customWhitecolor
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Avenir-Medium", size: 14)
        tv.textColor = UIColor.customWhitecolor
        tv.backgroundColor = UIColor.white
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()

}
