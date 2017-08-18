//
//  Model.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 24/07/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class Team: NSObject {
    
    var id: String?
    var name: String?
    var logo: String?
    var players: [Player]?
}

class Player: NSObject {
    
    var alias: String?
    var name: String?
    var age: String?
    var country: String?
    var imageName: String?
    var info: Info?
}

class Info: NSObject {
    
    var screenshots: [String]?
    var gears: [String]?
    var povs: [String]?
    var cfg: Config?
}

class Config: NSObject {
    
    var mouseSettings: [String]?
    var monitorSettings: [String]?
    var crosshaircfg: [String]?
}



