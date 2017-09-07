//
//  User.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 8/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
