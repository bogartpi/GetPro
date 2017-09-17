//
//  NewsDetailView.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 11/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

protocol NewsDetailsViewCellDelegate {
    func didTapComment(post: Post)
}

class NewsDetailCell: BaseCell {
    
    var delegate: NewsDetailsViewCellDelegate?
    
    var post: Post? {
        didSet {
            guard let imageUrl = post?.imageUrl else { return }
            imageView.loadImage(urlString: imageUrl)
            guard let title = post?.title else { return }
            titleLabel.text = title
            guard let date = post?.creationDate.timeAgoDisplayLong() else { return }
            timeStampLabel.text = date
        }
    }
    
    func handleComment() {
        print("comment")
        guard let post = self.post else { return }
        delegate?.didTapComment(post: post)
    }
    
    func handleShare() {
        print("share")
    }
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.customDarkGrayColor
        setDefaultShadow()
        setup()
        commentButton.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
    }
    
    func setup() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(timeStampLabel)
        addSubview(dividerItem)
        addSubview(categoryLabel)
        addSubview(commentButton)
        commentButton.addSubview(commentImage)
        addSubview(shareButton)
        shareButton.addSubview(shareImage)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 220)
        
        titleLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        timeStampLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: -8, paddingRight: 0, width: 0, height: 0)
        
        dividerItem.anchor(top: nil, left: timeStampLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 8, height: 30)
        dividerItem.centerYAnchor.constraint(equalTo: timeStampLabel.centerYAnchor).isActive = true
        
        categoryLabel.anchor(top: nil, left: dividerItem.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        categoryLabel.centerYAnchor.constraint(equalTo: timeStampLabel.centerYAnchor).isActive = true
        
        commentButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 30, height: 30)
        commentButton.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor).isActive = true
        
        commentImage.centerXAnchor.constraint(equalTo: commentButton.centerXAnchor).isActive = true
        commentImage.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor).isActive = true
        
        shareButton.anchor(top: nil, left: nil, bottom: nil, right: commentButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 30, height: 30)
        shareButton.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor).isActive = true
        
        shareImage.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor).isActive = true
        shareImage.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor).isActive = true
    }
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(color: UIColor.customWhitecolor, fontName: "Avenir-Medium", fontSize: 18, align: NSTextAlignment.left, lines: 3)
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel(color: UIColor.customWhitecolor, fontName: "Avenir-Medium", fontSize: 13)
        label.textAlignment = .left
        label.alpha = 0.9
        return label
    }()
    
    let dividerItem: UILabel = {
        let label = UILabel(color: UIColor.white, fontName: "Avenir-Light", fontSize: 15, align: NSTextAlignment.center, lines: 0)
        label.text = "|"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel(color: UIColor.customBlueColor, fontName: "Avenir-Heavy", fontSize: 13)
        label.textAlignment = .left
        label.alpha = 0.9
        label.text = "Touranment"
        return label
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    let commentImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "commentWhite")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.anchor(width: 20, height: 20)
        return iv
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    let shareImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "shareWhite")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.anchor(width: 20, height: 20)
        return iv
    }()
    
}

class BodyTextCell: BaseCell {
    
    override func setupViews() {
        super.setupViews()
        setup()
        backgroundColor = UIColor.customDarkGrayColor
        setDefaultShadow()
    }
    
    func setup() {
        addSubview(bodyLabel)
        bodyLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: -8, paddingRight: 8)
    }
    
    let bodyLabel: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Avenir-Light", size: 15)
        tv.textColor = UIColor.customWhitecolor
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.textAlignment = .left
        tv.bounces = false
        tv.isScrollEnabled = false 
        return tv
    }()
}














