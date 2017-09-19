//
//  AuthService.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 20/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    var username: String?
    var isLoggedIn = false
    
    func loginWithEmail(_ email: String, password: String,
                        completion: @escaping (_ success: Bool, _ message: String) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    if errCode == .userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                completion(false, "Failed to create a new account.")
                                return
                            }
                            completion(true, "Successfully created a new user.")
                        })
                    } else {
                        completion(false, "Sorry, Incorrect email or password")
                    }
                }
            } else {
                completion(true, "Successfully Logged In")
            }
        }
    }
}
