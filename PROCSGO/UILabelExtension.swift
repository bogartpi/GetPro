//
//  LabelExtension.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 3/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit 

public extension UILabel {
    public convenience init(topTitle: String, topFont: UIFont, topColor: UIColor,
                            bottomTitle: String, bottomFont: UIFont, bottomColor: UIColor,
                            align: NSTextAlignment) {
        self.init()
        let topAttribute = NSMutableAttributedString(string: topTitle,
                                                     attributes: [NSFontAttributeName: topFont,
                                                                  NSForegroundColorAttributeName: topColor])
        let bottomAttribute = NSMutableAttributedString(string: bottomTitle,
                                                        attributes: [NSFontAttributeName: bottomFont,
                                                                     NSForegroundColorAttributeName: bottomColor])
        topAttribute.append(bottomAttribute)
        self.attributedText = topAttribute
        self.numberOfLines = 0
        self.textAlignment = align
    }
    
    public convenience init(color: UIColor, fontName: String, fontSize: CGFloat, align: NSTextAlignment = .left, lines: Int = 1) {
        self.init()
        self.textColor = color
        self.textAlignment = align
        self.font = UIFont(name: fontName, size: fontSize)
        self.numberOfLines = lines
    }
    
    public convenience init(font: UIFont, color: UIColor) {
        self.init()
        self.textColor = color
        self.font = font
        self.textAlignment = .left
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.2
    }
}

