//
//  ProfileController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 29/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UICollectionViewController, LogOutHandlerProtocol {
    
    fileprivate let headerId = "headerId"
    fileprivate let profileCellId = "profileCellId"
    fileprivate let logoutCellId = "logoutCellId"
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        collectionView?.backgroundColor = UIColor.customGrayColor
        customizeNavController()
        changeNavigationTintColor(.white)
        
        collectionView?.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(LogOutCell.self, forCellWithReuseIdentifier: logoutCellId)
        
        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            self.user = User(dictionary: dictionary)
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
                // present login vc
            } catch let err {
                print("Failed to sign out:", err)
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
        return CGSize(width: view.frame.width, height: 200)
    }
    
    // MARK: - CollectionView Cells Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: logoutCellId, for: indexPath)  as! LogOutCell
        cell.myDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0  {
            return CGSize(width: view.frame.width, height: 60)
        }
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            
        }
    }
    
    
}
