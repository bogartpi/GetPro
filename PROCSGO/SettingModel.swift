//
//  SettingModel.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 7/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
