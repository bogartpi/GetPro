//
//  ConfigCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 6/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ConfigCell: BaseCell {
    
    let cellView: UIView = {
        let cv = UIView()
        cv.backgroundColor = customDarkGrayColor
        return cv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(color: customWhitecolor, fontName: "Avenir-Heavy", fontSize: 14)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel(color: customWhitecolor, fontName: "Avenir-Heavy", fontSize: 14)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        setup()
    }
    
    func setup() {
        
        addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(valueLabel)
        
        addConstraintsWithFormaat(format: "H:|-10-[v0]-10-|", views: cellView)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: cellView)
        cellView.addConstraintsWithFormaat(format: "H:|-16-[v0][v1]-16-|", views: titleLabel,valueLabel)
        cellView.addConstraintsWithFormaat(format: "V:|[v0]|", views: titleLabel)
        cellView.addConstraintsWithFormaat(format: "V:|[v0]|", views: valueLabel)
        
        setDefaultShadow()
    }
    
}
