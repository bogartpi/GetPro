//
//  WarningView.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 21/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class WarningView: BaseView {
    
    let warningView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customWarningColor
        return view
    }()
    
    let warningImage: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor.white
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "warning_icon")?.withRenderingMode(.alwaysTemplate)
        return iv
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel(color: UIColor.customWhitecolor, fontName: "Avenir-Medium", fontSize: 14, lines: 5)
        label.text = "Network Error.\nCouldn't connect to the server. Check your network connection"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        setupWarningView()
    }
    
    func setupWarningView() {
        addSubview(warningView)
        warningView.addSubview(warningImage)
        warningView.addSubview(warningLabel)
        
        warningView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        warningImage.anchor(top: warningView.topAnchor, left: warningView.leftAnchor, bottom: warningView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 50, height: 0)
        warningLabel.anchor(top: warningView.topAnchor, left: warningImage.rightAnchor, bottom: warningView.bottomAnchor, right: warningView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        UIView.animate(withDuration: 1.0, delay: 2.0, options: UIViewAnimationOptions.transitionFlipFromTop, animations: {
            self.warningView.frame.origin.y = self.frame.origin.y + self.frame.size.height
        }) { (finished) in
            Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.hideView), userInfo: nil, repeats: false)
        }
    }
    
    func hideView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.warningView.frame.origin.y = self.frame.origin.y - self.frame.size.height
        }) { (finished) in
            self.warningView.isHidden = true
        }
    }
}
