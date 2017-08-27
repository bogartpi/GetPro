//
//  AboutController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 7/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class AboutController: UIViewController {
    
    let aboutLabel: UILabel = {
        let label = UILabel(color: customDarkGrayColor, fontName: "Avenir", fontSize: 16, align: .center, lines: 15)
        label.text = "Welcome to The GetPro App!\n This is your guide into the world of CS:GO professionals. Get know all your favorite pro players. Check their configurations and gears. Explore and learn the best skills of pros by watching pov demos and setting their configs to feel like pro.\n\nNew features and updates are coming soon!\n\nFor any further suggestions related to this project or any support contact at: "
        return label
    }()
    
    let fbButton: UIButton = {
        let button = UIButton(imageName: "Facebook")
        button.addTarget(self, action: #selector(handleFbPage), for: .touchUpInside)
        return button
    }()
    
    let twitterButton: UIButton = {
        let button = UIButton(imageName: "Twitter")
        button.addTarget(self, action: #selector(handleTwitterPage), for: .touchUpInside)
        return button
    }()
    
    let instaButton: UIButton = {
        let button = UIButton(imageName: "Instagram")
        button.addTarget(self, action: #selector(handleInstaPage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = customWhitecolor
        navigationItem.title = "About"
        setup()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeNavigationTintColor(customWhitecolor)
    }
    
    func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [fbButton, twitterButton, instaButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: aboutLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 170, height: 50)
        stackView.centerXAnchor.constraint(equalTo: aboutLabel.centerXAnchor).isActive = true
    }
    
    func setup() {
        
        view.addSubview(aboutLabel)
        aboutLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 12, paddingBottom: 0, paddingRight: 12)
    }
    
    func handleFbPage() {
        openLink(social: "facebook.com", pageId: "pavelbogart") { (success) in
            print(success)
        }
    }
    
    func handleTwitterPage() {
        openLink(social: "twitter.com", pageId: "heyybogart") { (success) in
            print(success)
        }
    }
    
    func handleInstaPage() {
        openLink(social: "instagram.com", pageId: "pashabogart") { (success) in
            print(success)
        }
    }
}
