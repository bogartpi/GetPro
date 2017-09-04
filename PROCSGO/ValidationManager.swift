//
//  ValidationManager.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 3/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ValidationManager {
    public func validateEmail(_ value: String) -> Bool {
        let EMAIL_REGEX = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
        return emailTest.evaluate(with: value)
    }
    
    public func minimumLength(_ value: String, minimum: Int) -> Bool {
        if value.characters.count < minimum {
            return false
        }
        return true
    }
    
    public func trimmingWhiteSpaces(textField: UITextField) -> String? {
        let trimmedString = textField.text?.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
}
