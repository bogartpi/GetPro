//
//  Header.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 6/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ConfigHeader: BaseCell {
    
    let sectionNamelabel: UILabel = {
        let label = UILabel(color: UIColor.customRedColor, fontName: "Avenir-Heavy", fontSize: 16)
        return label
    }()
    
    let headerView: UIView = {
        let hv = UIView()
        hv.backgroundColor = UIColor.customGrayColor
        return hv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        setup()
    }
    
    func setup() {
        addSubview(headerView)
        headerView.addSubview(sectionNamelabel)
        headerView.pinEdges(to: self)
        sectionNamelabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
