//
//  DescriptionCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 5/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class DescriptionCell: BaseCell {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = UIFont(name: "Avenir-Heavy", size: 14)
        tv.textColor = customWhitecolor
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func setupViews() {
        super.setupViews()
        setup()
    }
    
    func setup() {
        addSubview(textView)
        addConstraintsWithFormaat(format: "H:|-14-[v0]-14-|", views: textView)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: textView)
    }

}
