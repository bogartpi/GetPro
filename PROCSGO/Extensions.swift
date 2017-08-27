//
//  Extensions.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 24/07/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

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
        navigationController?.navigationBar.barTintColor = customRedColor
        navigationController?.navigationBar.tintColor = customWhitecolor
    }
}

protocol Utilities {
    
}

extension NSObject: Utilities {
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable 
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
}

public extension UIColor {

    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

}

public extension UIView {
    
    func pinEdges(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func anchor(width: CGFloat, height: CGFloat) {
        self.anchor(top: nil,
                    left: nil,
                    bottom: nil,
                    right: nil,
                    paddingTop: 0,
                    paddingLeft: 0,
                    paddingBottom: 0,
                    paddingRight: 0,
                    width: width,
                    height: height)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
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

public extension UIView {
    
    func addConstraintsWithFormaat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

