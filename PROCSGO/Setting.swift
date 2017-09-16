//
//  SettingModel.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 7/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

enum SettingName: String {
    case Cancel = "Cancel"
    case RateUs = "Rate Us"
    case SendFeedback = "Send Feedback"
    case TellYourFriends = "Tell Your Friends"
    case ReportBug = "Report Bug"
    case About = "About"
}

struct Setting {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

