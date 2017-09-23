//
//  LogInController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 30/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class LogInController: UIViewController {
    
    var videoView: VideoView!
    var mainView: LoginMainView!
    var mainController: MainTabBarController?
    
    lazy var myactivityIndicator: UIActivityIndicatorView = {
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        myActivityIndicator.center = self.view.center
        myActivityIndicator.hidesWhenStopped = true
        return myActivityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        mainView.addSubview(myactivityIndicator)
    }
    
    func setupViews() {
        setupVideoView()
        setupMainView()
    }
    
    func setupVideoView() {
        let videoView = VideoView(frame: self.view.frame)
        self.videoView = videoView
        self.view.addSubview(videoView)
        videoView.pinEdges(to: self.view)
    }
    
    func setupMainView() {
        let mainView = LoginMainView(frame: self.view.frame)
        self.mainView = mainView
        self.mainView.signUpAction = self.signUpSwitch
        self.mainView.handleInputChangeAction = self.handleInputChange
        self.mainView.signInAction = self.handleSignIn
        self.videoView.addSubview(mainView)
        mainView.anchor(top: view.safeTopAnchor, left: view.safeLeftAnchor,
                        bottom: view.safeBottomAnchor, right: view.rightAnchor,
                        paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func handleSignIn() {
        guard let email = mainView.emailTextField.text else {
            self.showMessage("Error", description: "Please enter an email")
            return
        }
        guard let password = mainView.passwordTextField.text else {
            self.showMessage("Error", description: "Please enter a password")
            return
        }
        self.mainView.signInButton.isEnabled = false
        self.myactivityIndicator.startAnimating()
        AuthService.instance.loginWithEmail(email, password: password) { (success, message) in
            if success {
                self.myactivityIndicator.stopAnimating()
                self.mainView.signInButton.isEnabled = true
                self.setUsername()
                self.showMainTabBarController()
            } else {
                self.showMessage("Failure", description: message)
                self.myactivityIndicator.stopAnimating()
                self.mainView.signInButton.isEnabled = true
            }
        }
    }
    
    func setUsername() {
        if let user = Auth.auth().currentUser {
            AuthService.instance.isLoggedIn = true
            let emailComponents = user.email?.components(separatedBy: "@")
            if let username = emailComponents?[0] {
                AuthService.instance.username = username
            }
        } else {
            AuthService.instance.isLoggedIn = false
            AuthService.instance.username = nil
        }
    }
    
    func handleInputChange() {
        let isFormValid = mainView.emailTextField.text?.characters.count ?? 0 > 0 && mainView.passwordTextField.text?.characters.count ?? 0 > 0
        if isFormValid {
            mainView.signInButton.isEnabled = true
            mainView.signInButton.backgroundColor = UIColor.customBlueColor
            mainView.signInButton.alpha = 0.8
        } else {
            mainView.signInButton.isEnabled = false
            mainView.signInButton.backgroundColor = UIColor.customBlueColor
            mainView.signInButton.alpha = 0.5
        }
    }
    
    func showMainTabBarController() {
        guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
        
        mainTabBarController.setupViewControllers()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func signUpSwitch() {
        print("Sign ")
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
}

// MARK: - Setting View Layers

extension LogInController {
    override func viewDidAppear(_ animated: Bool) {
        setUsername()
        if AuthService.instance.isLoggedIn {
            guard let mainTabBarVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarVC.setupViewControllers()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        videoView.player.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        videoView.player.pause()
    }
}
