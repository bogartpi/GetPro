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
//    let imageWidth: Float
//    let imageHeight: Float
//    let title: String
//    let descriptionText: String
//    let creationDate: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
//        self.imageWidth = dictionary["imageWidth"] as? String ?? ""
//        self.imageHeight = dictionary["imageHeight"] as? String
    }
}
