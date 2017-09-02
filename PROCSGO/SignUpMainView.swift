//
//  SignUpMainView.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 2/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class SignUpMainView: UIView {
    
    var dismissAction: (() -> Void)?
    
    let closeButton: UIButton = {
        let button = UIButton(imageName: "cancel")
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func dismissController() {
        dismissAction?()
    }
    
    func setup() {
        addSubview(closeButton)
        
        closeButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
