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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoView()
        setupMainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        mainView.pinEdges(to: self.videoView)
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
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to create a user:", err.localizedDescription)
                return
            }
            print("Successfully created a user:", user?.uid ?? "")
            
            guard let image = self.mainView.plusButton.imageView?.image else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if let err = error {
                    print("Failed to upload profile image:", err)
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
                        return
                    }
                    print("Successfully saved user info to db")
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
