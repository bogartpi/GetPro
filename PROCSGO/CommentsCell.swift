//
//  CommentsCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 17/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CommentsCell: BaseCell {
    
    var comment: Comment? {
        didSet {
            guard let text = comment?.text else { return }
            textLabel.text = text
        }
    }
    
    override func setupViews() {
        super.setupViews()
        setup()
    }
    
    func setup() {
        backgroundColor = .red
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
    }
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
}
