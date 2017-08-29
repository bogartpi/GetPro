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
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    let newsTitleLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Medium", fontSize: 15, lines: 2)
        label.text = "Fnatic DreamHack Masters Champion"
        return label
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Medium", fontSize: 11)
        label.text = "20 likes"
        label.anchor(width: 40, height: 20)
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Medium", fontSize: 11)
        label.text = "12 comments"
        label.anchor(width: 70, height: 20)
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Medium", fontSize: 11)
        label.text = "54 views"
        label.anchor(width: 50, height: 20)
        return label
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel(color: .white, fontName: "Avenir-Medium", fontSize: 11)
        label.text = "3h"
        label.anchor(width: 20, height: 20)
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.anchor(width: 30, height: 30)
        button.backgroundColor = UIColor(red: 239.0/255.0, green: 83.0/255.0, blue: 80.0/255.0, alpha: 0.8)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.anchor(width: 30, height: 30)
        button.backgroundColor = UIColor(red: 38.0/255.0, green: 37.0/255.0, blue: 37.0/255.0, alpha: 0.8)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let likeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "likeWhite")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.anchor(width: 20, height: 18)
        return iv
    }()
    
    let commentImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "commentWhite")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.anchor(width: 20, height: 20)
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        setup()
        likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
    }
    
    func handleLike(_ sender: UIButton) {
        print("like")
    }
    
    func handleComment(_ sender: UIButton) {
        print("comment")
    }
    
    func setup() {
        
        let stackView = UIStackView(arrangedSubviews: [likesLabel, commentsLabel, viewsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        addSubview(newsImage)
        newsImage.addSubview(darkView)
        darkView.addSubview(newsTitleLabel)
        darkView.addSubview(stackView)
        darkView.addSubview(timeStampLabel)
        likeButton.addSubview(likeImage)
        commentButton.addSubview(commentImage)
        setButtonsStackView()
        
        addConstraintsWithFormaat(format: "H:|[v0]|", views: newsImage)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: newsImage)
        newsImage.addConstraintsWithFormaat(format: "H:|[v0]|", views: darkView)
        newsImage.addConstraintsWithFormaat(format: "V:|[v0]|", views: darkView)
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: -10, paddingRight: 0)
        newsTitleLabel.anchor(top: nil, left: leftAnchor, bottom: stackView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: -5, paddingRight: 0)
        timeStampLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -10, paddingRight: 10)
        likeImage.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor).isActive = true
        likeImage.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
        commentImage.centerXAnchor.constraint(equalTo: commentButton.centerXAnchor).isActive = true
        commentImage.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor).isActive = true
    }
    
    func setButtonsStackView() {
        let buttonStackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillProportionally
        buttonStackView.spacing = 10
        buttonStackView.isUserInteractionEnabled = true
        addSubview(buttonStackView)
        buttonStackView.anchor(top: topAnchor, left: nil,
                               bottom: nil, right: rightAnchor,
                               paddingTop: 20, paddingLeft: 0,
                               paddingBottom: 0, paddingRight: 10)
    }

}
