//
//  TextField.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 3/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

public extension UITextField {
    public convenience init(placeHolderName: String, leftViewImage: String = "", plusWidth: CGFloat = 0) {
        self.init()
        self.borderStyle = .none
        self.layer.cornerRadius = 3
        self.backgroundColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.2)
        self.textColor = UIColor(white: 0.9, alpha: 0.8)
        self.autocapitalizationType = .none
        self.tintColor = UIColor(white: 0.9, alpha: 0.8)
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        // placeholder
        let placeholderName = placeHolderName
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: placeholderName,
                                                                                     attributes: [NSFontAttributeName: UIFont(name: "Avenir Next-Light", size: 17) ?? UIFont.systemFont(ofSize: 17),
                                                                                                  NSForegroundColorAttributeName: UIColor(white: 0.7, alpha: 0.5)]))
        self.attributedPlaceholder = placeholder
        // leftView
        let image = UIImageView(image: UIImage(named: leftViewImage)?.withRenderingMode(.alwaysTemplate))
        image.tintColor = UIColor(white: 0.9, alpha: 0.8)
        image.contentMode = .center
        image.frame = CGRect(x: 0, y: 0, width: image.frame.width + plusWidth, height: image.frame.size.height)
        self.leftView = image
        self.leftViewMode = .always
    }
    
    func setLeftPaddingPoints(_ space: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
