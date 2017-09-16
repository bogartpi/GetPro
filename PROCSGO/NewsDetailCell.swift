//
//  NewsDetailView.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 11/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class NewsDetailCell: BaseCell {
    
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
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.customDarkGrayColor
        setDefaultShadow()
        setup()
    }
    
    func setup() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(timeStampLabel)
        addSubview(dividerItem)
        addSubview(categoryLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 220)
        
        titleLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
        
        timeStampLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        dividerItem.anchor(top: nil, left: timeStampLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 8, height: 30)
        dividerItem.centerYAnchor.constraint(equalTo: timeStampLabel.centerYAnchor).isActive = true
        
        categoryLabel.anchor(top: nil, left: dividerItem.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        categoryLabel.centerYAnchor.constraint(equalTo: timeStampLabel.centerYAnchor).isActive = true
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
        return tv
    }()
}














