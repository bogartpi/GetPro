//
//  UIView+Keyboard.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 21/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

extension UIView {
    
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    public func dismissKeyboard() {
        self.endEditing(true)
    }

}
