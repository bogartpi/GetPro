//
//  TeamCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 5/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class TeamsCell: BaseCell {
    
    let cellView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.customDarkGrayColor
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 3
        return v
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 14)
        label.textColor = UIColor.customWhitecolor
        label.backgroundColor = UIColor.customRedColor
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        setup()
    }
    
    func setup() {
        
        addSubview(cellView)
        cellView.addSubview(imageView)
        cellView.addSubview(teamNameLabel)
        
        cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        imageView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        imageView.anchor(width: 50, height: 0)
        imageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        teamNameLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        setDefaultShadow()
    }
    
}
