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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        mainView.pinEdges(to: self.videoView)
    }
    
    func handleSignIn() {
        guard let email = mainView.emailTextField.text else { return }
        guard let password = mainView.passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                // show alrt with the error
                print("Failed to sign in:", err.localizedDescription)
                return
            }
            print("Successfully logged in with user:", user?.uid ?? "")
            
            guard let mainTabBarVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarVC.setupViewControllers()
            self.dismiss(animated: true, completion: nil)
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
    
    func signUpSwitch() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
}
