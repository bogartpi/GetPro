//
//  NewsCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 27/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class NewsCell: BaseCell {
    
    let newsImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "newsImage1")
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customRedColor
        return view
    }()
    
    let newsTitleLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Medium", fontSize: 15, lines: 2)
        label.text = "Fnatic DreamHack Masters Champion"
        return label
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Medium", fontSize: 11)
        label.text = "3h"
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    let likeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "like_icon")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.anchor(width: 40, height: 20)
        return iv
    }()
    
    let commentImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "com_icon")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.anchor(width: 70, height: 50)
        return iv
    }()
    
    let shareImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "share_icon")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.anchor(width: 50, height: 30)
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.customGrayColor
        likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        setup()
    }
    
    func handleLike(_ sender: UIButton) {
        print("like")
    }
    
    func handleComment(_ sender: UIButton) {
        print("comment")
    }
    
    func handleShare(_ sender: UIButton) {
        print("share")
    }
    
    func setup() {
        addSubview(newsImage)
        newsImage.addSubview(darkView)
        darkView.addSubview(bottomView)
        darkView.addSubview(newsTitleLabel)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(timeStampLabel)
        
        likeButton.addSubview(likeImage)
        commentButton.addSubview(commentImage)
        shareButton.addSubview(shareImage)
        
        newsImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                         right: rightAnchor, paddingTop: 0, paddingLeft: 0,
                         paddingBottom: 0, paddingRight: 0)
        
        darkView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                        right: rightAnchor, paddingTop: 0, paddingLeft: 0,
                        paddingBottom: 0, paddingRight: 0)
        
        bottomView.anchor(top: nil, left: darkView.leftAnchor,
                          bottom: darkView.bottomAnchor, right: darkView.rightAnchor,
                          paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                          width: 0, height: 40)
        
        newsTitleLabel.anchor(top: nil, left: darkView.leftAnchor, bottom: bottomView.topAnchor, right: timeStampLabel.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 20, width: 0, height: 40)
        timeStampLabel.anchor(top: nil, left: nil, bottom: bottomView.topAnchor, right: darkView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -12, paddingRight: 16, width: 20, height: 10)
        
        likeButton.anchor(top: nil, left: leftAnchor,
                          bottom: bottomAnchor, right: nil,
                          paddingTop: 0, paddingLeft: 0,
                          paddingBottom: 0, paddingRight: 0,
                          width: (contentView.frame.size.width / 3), height: 40)
        
        commentButton.anchor(top: nil, left: likeButton.rightAnchor,
                             bottom: bottomAnchor, right: nil,
                             paddingTop: 0, paddingLeft: 0,
                             paddingBottom: 0, paddingRight: 0,
                             width: (contentView.frame.size.width / 3), height: 40)
        
        shareButton.anchor(top: nil, left: commentButton.rightAnchor,
                           bottom: bottomAnchor, right: nil,
                           paddingTop: 0, paddingLeft: 0,
                           paddingBottom: 0, paddingRight: 0,
                           width: (contentView.frame.size.width / 3), height: 40)
        
        likeImage.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor).isActive = true
        likeImage.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
        
        commentImage.centerXAnchor.constraint(equalTo: commentButton.centerXAnchor).isActive = true
        commentImage.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor).isActive = true
        
        shareImage.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor).isActive = true
        shareImage.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor).isActive = true
    }
    
}
