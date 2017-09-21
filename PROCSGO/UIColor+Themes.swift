//
//  Utilities.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 11/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

extension UIColor {
    static var customGrayColor: UIColor = {
        return UIColor(r: 54, g: 49, b: 49)
    }()
    
    static var customDarkGrayColor: UIColor = {
        return UIColor(r: 38, g: 37, b: 37)
    }()
    
    static var customRedColor: UIColor = {
        return UIColor(r: 239, g: 83, b: 80)
    }()
    
    static var customWhitecolor: UIColor = {
        return UIColor(r: 245, g: 245, b: 245)
    }()
    
    static var customBlueColor: UIColor = {
        return UIColor(r: 73, g: 144, b: 226)
    }()
    
    static var customWarningColor: UIColor = {
        return UIColor(r: 244, g: 67, b: 54)
    }()
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
