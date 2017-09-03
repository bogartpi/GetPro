//
//  SignUpController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 30/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        videoView.addSubview(mainView)
        mainView.pinEdges(to: self.videoView)
    }
    
    func handlePlusPhoto() {
        print(123)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            mainView.plusButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            mainView.plusButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }

        dismiss(animated: true, completion: nil)
    }
    
    func dismissController() {
        self.navigationController?.popViewController(animated: true)
    }

}
