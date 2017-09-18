//
//  SettingsLauncher.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 6/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//
//
//import UIKit
//import MessageUI
//import Social
//
//private let cellId = "cellId"
//private let cellHeight: CGFloat = 50
//
//class SettingsLauncher: NSObject {
//    
//    let blackView = UIView()
//    
//    var newsController: NewsController?
//    
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.customDarkGrayColor
//        cv.layer.shadowColor = UIColor.black.cgColor
//        cv.layer.shadowOffset = CGSize(width: 0, height: 1)
//        cv.layer.shadowOpacity = 1
//        cv.layer.shadowRadius = 2.0
//        cv.clipsToBounds = false
//        cv.layer.masksToBounds = false
//        return cv
//    }()
//    
//    override init() {
//        super.init()
//        collectionView.dataSource = self
//        collectionView.delegate = self
//    }
//    
//    func showSettings() {
//        
//        if let window = UIApplication.shared.keyWindow {
//            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
//            blackView.frame = window.frame
//            blackView.alpha = 0
//            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
//            
//            let height: CGFloat = CGFloat(settings.count) * cellHeight
//            let y = window.frame.height - height
//            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
//            
//            window.addSubview(blackView)
//            window.addSubview(collectionView)
//            
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//                self.blackView.alpha = 1
//                
//                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//            }, completion: nil)
//        }
//    }
//    
//    func handleDismiss() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.blackView.alpha = 0
//            if let window = UIApplication.shared.keyWindow {
//                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//            }
//        }, completion: nil)
//    }
//    
//    
//    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
//        guard let url = URL(string: "itms-apps://itunes.apple.com/us/app/\(appId)?action=write-review&mt=8") else {
//            completion(false)
//            return
//        }
//        guard #available(iOS 10, *) else {
//            completion(UIApplication.shared.openURL(url))
//            return
//        }
//        UIApplication.shared.open(url, options: [:], completionHandler: completion)
//    }
//    
//    func showAboutController() {
//        let aboutVC = AboutController()
//        newsController?.navigationController?.pushViewController(aboutVC, animated: true)
//    }
//
//}
//

//
//extension SettingsLauncher: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        handleDismiss()
//        switch indexPath.item {
//        case 0:
//            rateApp(appId: appId) { success in
//                print("RateApp \(success)")
//            }
//        case 1:
//            createEmailController(sendToEmail: ["getprocsgo@gmail.com"], subject: "App Feedback", msgBody: "Hi Team!\n\nI would like to share the following feedback.")
//        case 2:
//            shareTheApp()
//        case 3:
//            createEmailController(sendToEmail: ["getprocsgo@gmail.com"], subject: "Report Bug", msgBody: "Hi Team!\n\nI have found the bug which I would like to share with you.")
//        case 4:
//            showAboutController()
//        default:
//            print("IndexPath is wrong")
//        }
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: cellHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return settings.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        return cell
//    }
//    
//}

