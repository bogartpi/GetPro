//
//  ConfCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 9/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

protocol DetailsHandlerProtocol {
    func handleConfigController()
    func handlePovsController()
}

class ConfCell: BaseCell {
    
    var myDelegate: DetailsHandlerProtocol?
    
    let confButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.customDarkGrayColor
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
    let confImageView: UIImageView = {
        let iv = UIImageView(imageName: "cfg")
        iv.isUserInteractionEnabled = false
        return iv
    }()
    
    let povsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.customDarkGrayColor
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
    let povsImageView: UIImageView = {
        let iv = UIImageView(imageName: "video")
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = false
        return iv
    }()
    
    func handleCfg(sender: UIButton) {
        myDelegate?.handleConfigController()
    }
    
    func handlePovs(sender: UIButton) {
        myDelegate?.handlePovsController()
    }
    
    override func setupViews() {
        super.setupViews()
        setup()
        setDefaultShadow()
    }

    func setup() {
    
        confButton.addTarget(self, action: #selector(handleCfg(sender:)), for: .touchUpInside)
        povsButton.addTarget(self, action: #selector(handlePovs(sender:)), for: .touchUpInside)
    
        addSubview(confButton)
        addSubview(povsButton)
        
        confButton.addSubview(confImageView)
        povsButton.addSubview(povsImageView)
        
        confButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: contentView.frame.size.width / 2 - 24, height: 40)
        povsButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: contentView.frame.size.width / 2 - 24, height: 40)
        
        confImageView.anchor(width: 20, height: 20)
        confImageView.centerXAnchor.constraint(equalTo: confButton.centerXAnchor).isActive = true
        confImageView.centerYAnchor.constraint(equalTo: confButton.centerYAnchor).isActive = true
        
        povsImageView.anchor(width: 20, height: 20)
        povsImageView.centerXAnchor.constraint(equalTo: povsButton.centerXAnchor).isActive = true
        povsImageView.centerYAnchor.constraint(equalTo: povsButton.centerYAnchor).isActive = true
    
    }

}
