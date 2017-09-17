//
//  User.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 8/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

struct User {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
