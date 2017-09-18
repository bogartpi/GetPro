//
//  ProfileController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 29/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UICollectionViewController {
    
    fileprivate let headerId = "headerId"
    fileprivate let profileCellId = "profileCellId"
    
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
        if indexPath.item == 0 {
            
        }
    }
    
    
}
