//
//  HandleKeyboardExtension.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 20/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func keyboardWillShow(notif: NSNotification) {
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    public func keyboardWillHide(notif: NSNotification) {
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    public func dismissKeyboard() {
        view.endEditing(true)
    }
}

