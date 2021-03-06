//
//  UIViewExtension.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 3/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

extension UIView: UITextFieldDelegate {
    
    func animateTextField(textField: UITextField, up: Bool) {
        var movementDistance: CGFloat = -100
        if self.frame.height == 568 {
            movementDistance = -130
        }
        
        let movementDuration: Double = 0.3
        var movement:CGFloat = 0
        
        if up {
            movement = movementDistance
        }
            
        else {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.frame = self.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTextField(textField: textField, up: true)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        animateTextField(textField: textField, up: false)
        let validationManager = ValidationManager()
        textField.text = validationManager.trimmingWhiteSpaces(textField: textField)
    }
}

extension UIView: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "News Description" {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "News Description"
            textView.textColor = .lightGray
        }
    }
}
