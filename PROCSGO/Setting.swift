//
//  SettingModel.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 7/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

enum SettingName: String {
    case LogOut = "Log Out"
    case PushNotifications = "Push Notifications"
    case TellYourFriends = "Tell Your Friends"
    case RateUs = "Rate Us"
    case SendFeedback = "Send Feedback"
    case ReportProblem = "Report a Problem"
    case TermsConditions = "Terms & Conditions"
    case PrivacyPolicy = "Privacy Policy"
    case About = "About"
}

enum ImageName: String {
    case LogOutImage = "logout_icon"
    case PushNotificationsImage = "notify_icon"
    case TellYourFriendsImage = "spread_icon"
    case RateUsImage = "rateus_icon"
    case SendFeedbackImage = "feedback_icon"
    case ReportProblemImage = "report_icon"
    case TermsConditionsImage = "terms_icon"
    case PrivacyPolicyImage = "privacy_icon"
    case AboutImage = "about_icon"
}

struct Setting {
    let name: SettingName
    let imageName: ImageName
    
    init(name: SettingName, imageName: ImageName) {
        self.name = name
        self.imageName = imageName
    }
}




