//
//  ProfileCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 7/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ProfileCell: BaseCell {
    
    override func setupViews() {
        super.setupViews()
        
    }
}

protocol LogOutHandlerProtocol {
    func handleLogOut()
}

class LogOutCell: BaseCell {
    
    var myDelegate: LogOutHandlerProtocol?
    
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Log Out", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.white])
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        logOutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        setup()
    }
    
    func setup() {
        addSubview(logOutButton)
        logOutButton.anchor(width: 100, height: 30)
        logOutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        logOutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func logout(sender: UIButton) {
        myDelegate?.handleLogOut()
    }
}
