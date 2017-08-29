//
//  PovController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 1/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class PovController: UICollectionViewController {
    
    var povs: [String]?
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let adv = UIActivityIndicatorView()
        adv.color = customWhitecolor
        return adv
    }()
    
    let warningView: UIView = {
        let view = UIView()
        view.backgroundColor = customRedColor
        return view
    }()
    
    let warningImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = customWhitecolor
        return iv
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel(color: customWhitecolor, fontName: "Avenir-Medium", fontSize: 14, lines: 5)
        label.text = "Network Error.\nCouldn't connect to the server. Check your network connection"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = customGrayColor
        collectionView?.isUserInteractionEnabled = true
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        navigationItem.titleView = activityIndicatorView
        activityIndicatorView.startAnimating()
        checkReachability()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 20)!]
        customizeNavController()
        setupNavigationButtons()
    }
    
    private func setupNavigationButtons() {
        let backImage = UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal)
        let backButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(dismissController))
        navigationItem.leftBarButtonItems = [backButtonItem]
    }
    
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupWarningView() {
        view.addSubview(warningView)
        warningView.addSubview(warningImage)
        warningView.addSubview(warningLabel)

        warningView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        warningImage.anchor(top: warningView.topAnchor, left: warningView.leftAnchor, bottom: warningView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 0)
        warningLabel.anchor(top: warningView.topAnchor, left: warningImage.rightAnchor, bottom: warningView.bottomAnchor, right: warningView.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions.transitionFlipFromTop, animations: {
            self.warningView.frame.origin.y = self.view.frame.origin.y + self.view.frame.size.height
        }) { (finished) in
            self.activityIndicatorView.stopAnimating()
            Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.hideView), userInfo: nil, repeats: false)
        }
    }
    
    func hideView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.warningView.frame.origin.y = self.view.frame.origin.y - self.view.frame.size.height
        }) { (finished) in
            self.warningView.isHidden = true
        }
    }
    
    func checkReachability() {
        if currentReachabilityStatus == .reachableViaWiFi {
            print("connected")
        } else if currentReachabilityStatus == .reachableViaWWAN {
            print("connected wwan")
        } else {
            setupWarningView()
            print("not connected")
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicatorView.stopAnimating()
        navigationItem.titleView = nil
        navigationItem.title = "POVs"
    }
    
    func loadYoutube(webView: UIWebView ,videoID: String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        webView.loadRequest( URLRequest(url: youtubeURL) )
    }
}

extension PovController: UICollectionViewDelegateFlowLayout, UIWebViewDelegate {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = povs?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.webView.delegate = self
        if let pov = self.povs?[indexPath.item] {
            DispatchQueue.main.async {
                self.loadYoutube(webView: cell.webView, videoID: pov)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 28, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
}








