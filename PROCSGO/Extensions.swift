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

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = 1
            unit = "min"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "h"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "d"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "w"
        } else {
            quotient = secondsAgo / month
            unit = "m"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "") ago"
        
    }
}

