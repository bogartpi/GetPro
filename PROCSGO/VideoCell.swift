//
//  VideoCell.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 6/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    let webView: UIWebView = {
        let wv = UIWebView()
        wv.scalesPageToFit = true
        wv.backgroundColor = .clear
        wv.isOpaque = false
        return wv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(webView)
        
        addConstraintsWithFormaat(format: "H:|[v0]|", views: webView)
        addConstraintsWithFormaat(format: "V:|[v0]|", views: webView)
        
        setDefaultShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
