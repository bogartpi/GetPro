//
//  ProfileController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 29/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase
import Social
import MessageUI

class ProfileController: UICollectionViewController {
    
    fileprivate let headerId = "headerId"
    fileprivate let profileCellId = "profileCellId"
    fileprivate let appId = "id1271666107"
    
    var user: User?
    
    let settings: [Setting] = {
        return [Setting(name: .PushNotifications, imageName: .PushNotificationsImage),
                Setting(name: .TellYourFriends, imageName: .TellYourFriendsImage),
                Setting(name: .RateUs, imageName: .RateUsImage),
                Setting(name: .SendFeedback, imageName: .SendFeedbackImage),
                Setting(name: .ReportProblem, imageName: .ReportProblemImage)]
    }()
    
    let infoSettings: [Setting] = {
        return [Setting(name: .TermsConditions, imageName: .TermsConditionsImage),
                Setting(name: .PrivacyPolicy, imageName: .PrivacyPolicyImage),
                Setting(name: .About, imageName: .AboutImage)]
    }()
    
    let logoutSettings: [Setting] = {
        return [Setting(name: .LogOut, imageName: .LogOutImage)]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        collectionView?.backgroundColor = UIColor.customGrayColor
        customizeNavController()
        changeNavigationTintColor(.white)
        
        collectionView?.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellId)

        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            self.user = User(uid: uid, dictionary: dictionary)
            self.collectionView?.reloadData()
        }) { (err) in
            print("Failed to fetch user:", err)
        }
    }
    
    func handleLogOut() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                let loginController = LogInController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            } catch let err {
                print("Failed to log out:", err)
                self.showMessage("Failed to log out", description: err.localizedDescription)
            }
        })) 
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func showAboutController() {
        let aboutVC = AboutController()
        navigationController?.pushViewController(aboutVC, animated: true)
    }
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    // MARK: - HeadView Methods
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeaderView
            header.user = self.user
            return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 100)
        } else {
            return CGSize(width: view.frame.width, height: 0)
        }
    }
    
    // MARK: - CollectionView Cells Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return settings.count
        }
        if section == 1 {
            return infoSettings.count
        }
        return logoutSettings.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellId, for: indexPath)  as! ProfileCell
            cell.setting = settings[indexPath.item]
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellId, for: indexPath)  as! ProfileCell
            cell.setting = infoSettings[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellId, for: indexPath)  as! ProfileCell
        cell.setting = logoutSettings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.item) {
        case (0,0):
            // push notifications
            print("push notify")
        case (0,1):
            // tell friends
            self.shareTheApp()
        case (0,2):
            // rate us
            self.rateApp(appId: appId) { success in
               print("RateApp \(success)")
            }
        case (0,3):
            // send feedback
            self.createEmailController(sendToEmail: ["getprocsgo@gmail.com"], subject: "App Feedback",
                                       msgBody: "Hi Team!\n\nI would like to share the following feedback.")
        case (0,4):
            // report a problem
            self.createEmailController(sendToEmail: ["getprocsgo@gmail.com"], subject: "Report Bug",
                                       msgBody: "Hi Team!\n\nI have found the bug which I would like to share with you.")
        case (1,0):
            // terms and conds
            print("terms")
        case (1,1):
            // privacy policy
            print("privacy")
        case (1,2):
            // about
            self.showAboutController()
        case (2,0):
            // logout
            self.handleLogOut()
        default:
            break
        }
    }
}

extension ProfileController: MFMailComposeViewControllerDelegate {

    func customAlert(title: String, msg: String) {
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
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
                self.present(tweetComposer!, animated: true, completion: nil)
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
                self.present(fbComposer!, animated: true, completion: nil)
            } else {
                self.customAlert(title: "Facebook Unavailable", msg: "Check your settings Settings > Facebook to set up your Facebook account.")
            }
        }
        // Cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        shareActionSheet.addAction(twitterActionSheet)
        shareActionSheet.addAction(facebookActionSheet)
        shareActionSheet.addAction(cancelAction)
        self.present(shareActionSheet, animated: true, completion: nil)
    }

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
            self.navigationController?.present(emailController, animated: true, completion: nil)
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
        self.dismiss(animated: true, completion: nil)
    }

}

