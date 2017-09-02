//
//  Extensions.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 24/07/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Foundation

public extension UIViewController {
    
    func changeNavigationTintColor(_ color: UIColor) {
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = color
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func openLink(social: String, pageId: String, completion: @escaping ((_ success: Bool)->())) {
        
        if UIApplication.shared.canOpenURL(URL(string: "https://\(social)/\(pageId)")!) {
            UIApplication.shared.open(URL(string: "https://\(social)/\(pageId)")!, options: [:])
        }
    }
    
    func customizeNavController() {
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 2
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.customRedColor
        navigationController?.navigationBar.tintColor = UIColor.customWhitecolor
    }
}

public extension UIColor {

    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

}

public extension UIView {
    func setDefaultShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}


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

public extension UIImageView {
    
    public convenience init(imageName: String) {
        self.init()
        self.contentMode = .scaleAspectFill
        self.image = UIImage(named: imageName)
    }
}

public extension UIButton {
    public convenience init(imageName: String) {
        self.init(type: .system)
        self.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.contentMode = .scaleAspectFit
    }
}

public extension UITextField {
    public convenience init(placeHolderName: String, leftViewImage: String, plusWidth: CGFloat) {
        self.init()
        self.borderStyle = .none
        self.layer.cornerRadius = 3
        self.backgroundColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.2)
        self.textColor = UIColor(white: 0.9, alpha: 0.8)
        self.autocapitalizationType = .none
        self.tintColor = UIColor(white: 0.9, alpha: 0.8)
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        self.isSecureTextEntry = true
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
}
