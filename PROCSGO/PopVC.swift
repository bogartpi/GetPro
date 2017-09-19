//
//  PopVC.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 21/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {
    
    var popImageVIew: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel(color: UIColor.customRedColor, fontName: "Chalkduster", fontSize: 54, align: .center)
        return label
    }()
    
    var passedImage: UIImage!
    var passedAlias: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageVIew.image = passedImage
        nameLabel.text = passedAlias
        view.addSubview(popImageVIew)
        view.addSubview(nameLabel)
        popImageVIew.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nameLabel.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        nameLabel.anchor(top: popImageVIew.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 140)
    }
    
    func initData(forImage image: String, forLabel alias: String) {
        self.passedImage = UIImage(named: image)
        self.passedAlias = alias
    }
    
    func doubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
