//
//  SettingsLauncher.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 6/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import MessageUI
import Social

enum SettingName: String {
    case Cancel = "Cancel"
    case RateUs = "Rate Us"
    case SendFeedback = "Send Feedback"
    case TellYourFriends = "Tell Your Friends"
    case ReportBug = "Report Bug"
    case About = "About"
}

class SettingsLauncher: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate
{
    
    let appId = "id1271666107"
    
    let blackView = UIView()
    
    private let cellId = "cellId"
    
    private let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        return [Setting(name: .RateUs, imageName: "rate_icon"),
                Setting(name: .SendFeedback, imageName: "feedback_icon"),
                Setting(name: .TellYourFriends, imageName: "share_icon"),
                Setting(name: .ReportBug, imageName: "report_icon"),
                Setting(name: .About, imageName: "about_icon"),
                Setting(name: .Cancel, imageName: "cancel_icon") ]
    }()
    
    var newsController: NewsController?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = customDarkGrayColor
        cv.layer.shadowColor = UIColor.black.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 1)
        cv.layer.shadowOpacity = 1
        cv.layer.shadowRadius = 2.0
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        return cv
    }()
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }, completion: nil)
    }
    
    
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string: "itms-apps://itunes.apple.com/us/app/\(appId)?action=write-review&mt=8") else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    func showAboutController() {
        let aboutVC = AboutController()
        newsController?.navigationController?.pushViewController(aboutVC, animated: true)
    }
    
    func customAlert(title: String, msg: String) {
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.newsController?.present(alertVC, animated: true, completion: nil)
    }
    
    func shareTheApp() {
        let shareActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // Twitter
        let twitterActionSheet = UIAlertAction(title: "Share on Twitter", style: .default) { (action) in
            // display twitter composer
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                tweetComposer?.setInitialText("Getpro App is waiting for you. Get it on your phone and enjoy exploring CS:GO pro players.")
                tweetComposer?.add(UIImage(named: "shareImage1"))
                tweetComposer?.add(URL(string: "https://itunes.apple.com/us/app/getpro-cs-go/id1271666107?ls=1&mt=8"))
                self.newsController?.present(tweetComposer!, animated: true, completion: nil)
            } else {
                self.customAlert(title: "Twitter Unavailable", msg: "Check your settings Settings > Twitter to set up your Twitter account.")
            }
        }
        
        // Facebook
        let facebookActionSheet = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
            // display twitter composer
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                fbComposer?.setInitialText("Getpro App is waiting for you. Get it on your phone and enjoy exploring CS:GO pro players.")
                fbComposer?.add(UIImage(named: "shareImage1"))
                fbComposer?.add(URL(string: "https://itunes.apple.com/us/app/getpro-cs-go/id1271666107?ls=1&mt=8"))
                self.newsController?.present(fbComposer!, animated: true, completion: nil)
            } else {
                self.customAlert(title: "Facebook Unavailable", msg: "Check your settings Settings > Facebook to set up your Facebook account.")
            }
        }
        // Cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        shareActionSheet.addAction(twitterActionSheet)
        shareActionSheet.addAction(facebookActionSheet)
        shareActionSheet.addAction(cancelAction)
        self.newsController?.present(shareActionSheet, animated: true, completion: nil)
    }
    
    // MARK: - MFMailComposeVC Methods
    
    func configureEmailComposeViewController(setToRecipients: [String], setSubject: String, setMsgBody: String) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(setToRecipients)
        mailComposeVC.setSubject(setSubject)
        mailComposeVC.setMessageBody(setMsgBody, isHTML: false)
        return mailComposeVC
    }
    
    func createEmailController(sendToEmail: [String], subject: String, msgBody: String) {
        let emailController = configureEmailComposeViewController(setToRecipients: sendToEmail, setSubject: subject, setMsgBody: msgBody)
        if MFMailComposeViewController.canSendMail() {
            newsController?.navigationController?.present(emailController, animated: true, completion: nil)
        } else {
            print("ERROR")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Cancelled Mail")
        case MFMailComposeResult.sent:
            print("Mail sent")
        default:
            break
        }
        newsController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss()
        switch indexPath.item {
        case 0:
            rateApp(appId: appId) { success in
                print("RateApp \(success)")
            }
        case 1:
            createEmailController(sendToEmail: ["getprocsgo@gmail.com"], subject: "App Feedback", msgBody: "Hi Team!\n\nI would like to share the following feedback.")
        case 2:
            shareTheApp()
        case 3:
            createEmailController(sendToEmail: ["getprocsgo@gmail.com"], subject: "Report Bug", msgBody: "Hi Team!\n\nI have found the bug which I would like to share with you.")
        case 4:
            showAboutController()
        default:
            print("IndexPath is wrong")
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
}


