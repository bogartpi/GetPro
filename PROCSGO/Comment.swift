//
//  Comment.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 17/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation

struct Comment {
    let text: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? "" 
    }
}
