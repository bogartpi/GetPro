//
//  Comment.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 17/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

struct Comment {
    
    let user: User
    let text: String
    let uid: String
    let createDate: Date
    
    init(user: User ,dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["createDate"] as? Double ?? 0
        self.createDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
