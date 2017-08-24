//
//  PlayersCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 5/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    
    var player: Player? {
        didSet {
            if let imageName = player?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            if let alias = player?.alias {
                aliasDataLabel.text = alias
            }
            if let name = player?.name {
                nameDataLabel.text = name
            }
            if let age = player?.age {
                ageDataLabel.text = "\(age) y.o,"
            }
            if let country = player?.country {
                countryDataLabel.text = country
                flagImageView.image = UIImage(named: country)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "get_right")
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds =  true
        return iv
    }()
    
    let aliasDataLabel: UILabel = {
        let label = UILabel(color: customRedColor, fontName: "Chalkduster", fontSize: 24)
        return label
    }()
    
    let nameDataLabel: UILabel = {
        let label = UILabel(color: customWhitecolor, fontName: "Avenir-Book", fontSize: 13)
        return label
    }()
    
    let ageDataLabel: UILabel = {
        let label = UILabel(color: customWhitecolor, fontName: "Avenir-Book", fontSize: 13)
        return label
    }()
    
    let countryDataLabel: UILabel = {
        let label = UILabel(color: customWhitecolor, fontName: "Avenir-Book", fontSize: 13)
        return label
    }()
    
    let flagImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 0
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = customDarkGrayColor
        setDefaultShadow()
        setupViews()
    }
    
    fileprivate func setupViews() {
        
        let topStackView = UIStackView(arrangedSubviews: [aliasDataLabel, nameDataLabel])
        topStackView.distribution = .fillProportionally
        topStackView.spacing = 0
        topStackView.axis = .vertical
        topStackView.alignment = .leading
        
        addSubview(imageView)
        addSubview(topStackView)
        addSubview(ageDataLabel)
        addSubview(countryDataLabel)
        addSubview(flagImageView)
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil,
                         paddingTop: 0, paddingLeft: 10,
                         paddingBottom: 0, paddingRight: 0,
                         width: 80, height: 80)
        aliasDataLabel.anchor(width: 0, height: 40)
        topStackView.anchor(top: topAnchor, left: imageView.rightAnchor,
                              bottom: nil, right: rightAnchor, paddingTop: 15,
                              paddingLeft: 20, paddingBottom: 0, paddingRight: 12,
                              width: 0, height: 60)
        ageDataLabel.anchor(top: topStackView.bottomAnchor, left: imageView.rightAnchor,
                            bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0,
                            paddingRight: 0, width: 40, height: 0)
        countryDataLabel.anchor(top: topStackView.bottomAnchor, left: ageDataLabel.rightAnchor,
                                bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5,
                                paddingBottom: 0, paddingRight: 0)
        flagImageView.anchor(top: topStackView.bottomAnchor, left: countryDataLabel.rightAnchor,
                             bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8,
                             paddingBottom: 0, paddingRight: 0, width: 19, height: 14)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
