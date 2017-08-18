//
//  DescriptionCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 5/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = UIFont(name: "Avenir-Heavy", size: 14)
        tv.textColor = customWhitecolor
        tv.backgroundColor = .clear
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textView)
        
        addConstraintsWithFormaat(format: "H:|-14-[v0]-14-|", views: textView)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
