//
//  NewsCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 27/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class NewsCell: BaseCell {
    
    var post: Post? {
        didSet {
            guard let imageUrl = post?.imageUrl else { return }
            newsImage.loadImage(urlString: imageUrl)
            newsTitleLabel.text = post?.title
            timeStampLabel.text = post?.creationDate.timeAgoDisplayLong()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.customGrayColor
        setup()
    }
    
    func setup() {
        addSubview(newsImage)
        addSubview(newsTitleLabel)
        addSubview(timeStampLabel)
        addSubview(dividerItem)
        addSubview(categoryLabel)
        
        newsImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                         right: nil, paddingTop: 0, paddingLeft: 0,
                         paddingBottom: 0, paddingRight: 0, width: self.frame.width / 2)
        
        newsTitleLabel.anchor(top: topAnchor, left: newsImage.rightAnchor, bottom: nil,
                              right: rightAnchor, paddingTop: 4, paddingLeft: 8,
                              paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        timeStampLabel.anchor(top: nil, left: newsImage.rightAnchor, bottom: bottomAnchor,
                              right: nil, paddingTop: 0, paddingLeft: 8,
                              paddingBottom: -4, paddingRight: 8, width: 0, height: 0)
    }
    
    let newsImage: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.darkGray
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let newsTitleLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Heavy", fontSize: 16, lines: 3)
        label.text = "Fnatic DreamHack Masters Champion"
        label.alpha = 0.9
        return label
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Light", fontSize: 12)
        label.textAlignment = .right
        label.alpha = 0.9
        return label
    }()
    
    let dividerItem: UILabel = {
        let label = UILabel(color: UIColor.white, fontName: "Avenir-Light", fontSize: 12, align: NSTextAlignment.center, lines: 0)
        label.text = "|"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel(color: UIColor.customBlueColor, fontName: "Avenir-Medium", fontSize: 12)
        label.textAlignment = .left
        label.alpha = 0.9
        label.text = "Touranment"
        return label
    }()
    
}
