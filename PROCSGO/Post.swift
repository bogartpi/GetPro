//
//  News.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 13/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

struct Post {
    let imageUrl: String
    let creationDate: Double
    let imageWidth: Int
    let imageHeight: Int
    let title: String
    let descriptionText: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.creationDate = dictionary["creationDate"] as! Double
        self.imageWidth = dictionary["imageWith"] as! Int
        self.imageHeight = dictionary["imageHeight"] as! Int
        self.title = dictionary["title"] as? String ?? ""
        self.descriptionText = dictionary["body"] as? String ?? ""
    }
}
