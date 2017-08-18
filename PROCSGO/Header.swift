//
//  Header.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 6/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class Header: UICollectionViewCell {
    
    let sectionNamelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        label.textColor = customRedColor
        return label
    }()
    
    let headerView: UIView = {
        let hv = UIView()
        hv.backgroundColor = customGrayColor
        return hv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(headerView)
        headerView.addSubview(sectionNamelabel)
        
        addConstraintsWithFormaat(format: "H:|[v0]|", views: headerView)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: headerView)
        sectionNamelabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}
