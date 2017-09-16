//
//  News.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 13/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

struct Post {
    
    var id: String?
    
    let imageUrl: String
    let creationDate: Date
    let title: String
    let descriptionText: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.descriptionText = dictionary["body"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
