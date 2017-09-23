//
//  SignUpController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 30/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    var videoView: VideoView!
    var mainView: SignUpMainView!
    
    lazy var myactivityIndicator: UIActivityIndicatorView = {
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        myActivityIndicator.center = self.view.center
        myActivityIndicator.hidesWhenStopped = true
        return myActivityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.addSubview(myactivityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func handleInputChange() {
        let isFormValid = mainView.userNameTextField.text?.characters.count ?? 0 > 0 &&
            mainView.emailTextField.text?.characters.count ?? 0 > 0 && mainView.passwordTextField.text?.characters.count ?? 0 > 0
        if isFormValid {
            mainView.signUpButton.isEnabled = true
            mainView.signUpButton.backgroundColor = UIColor.customRedColor
            mainView.signUpButton.alpha = 0.8
        } else {
            mainView.signUpButton.isEnabled = false
            mainView.signUpButton.backgroundColor = UIColor.customRedColor
            mainView.signUpButton.alpha = 0.5 
        }
    }
    
    func handleSignUp() {
        guard let username = mainView.userNameTextField.text, username.characters.count > 0 else { return }
        guard let email = mainView.emailTextField.text, email.characters.count > 0 else { return }
        guard let password = mainView.passwordTextField.text, password.characters.count > 0 else { return }
        self.myactivityIndicator.startAnimating()
        self.mainView.signUpButton.isEnabled = false
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                self.myactivityIndicator.stopAnimating()
                self.mainView.signUpButton.isEnabled = true
                
                self.showMessage("Failed to create a user", description: err.localizedDescription)
                return
            }
            print("Successfully created a user:", user?.uid ?? "")
            
            guard let image = self.mainView.plusButton.imageView?.image else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if let err = error {
                    self.myactivityIndicator.stopAnimating()
                    self.mainView.signUpButton.isEnabled = true
                    self.showMessage("Failed to upload profile image", description: err.localizedDescription)
                    return
                }
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                print("Successfully uploaded profile image:", profileImageUrl)
                
                guard let uid = user?.uid else { return }
                let dictValues = ["username": username,
                                  "profileImageUrl": profileImageUrl ]
                let values = [uid: dictValues]
                
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
                    
                    if let err = error {
                        print("Failed to save user info into db:", err)
                        self.myactivityIndicator.stopAnimating()
                        self.mainView.signUpButton.isEnabled = true
                        self.showMessage("Failed to save user info", description: err.localizedDescription)
                        return
                    }
                    print("Successfully saved user info to db")
                    self.myactivityIndicator.stopAnimating()
                    self.mainView.signUpButton.isEnabled = true
                    
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                    mainTabBarController.setupViewControllers()
                    self.dismiss(animated: true, completion: nil)
                })

            })
        }
    }
    
    func handlePlusPhoto() {
        print("added photo")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func dismissController() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Setting View Layers

extension SignUpController {
    func setup() {
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
        let mainView = SignUpMainView(frame: self.view.frame)
        self.mainView = mainView
        self.mainView.dismissAction = self.dismissController
        self.mainView.plusPhotoAction = self.handlePlusPhoto
        self.mainView.signUpAction = self.handleSignUp
        self.mainView.inputChangeAction = self.handleInputChange
        videoView.addSubview(mainView)
        mainView.anchor(top: videoView.safeTopAnchor, left: videoView.safeLeftAnchor,
                        bottom: videoView.safeBottomAnchor, right: videoView.safeRightAnchor,
                        paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
}

// MARK: - Image Picker Methods

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            mainView.plusButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            mainView.plusButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
