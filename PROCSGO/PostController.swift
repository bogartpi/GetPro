//
//  NewsPostController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 11/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class PostController: UIViewController {
    
    var mainView: PostView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupNavigationButtons()
        customizeNavController()
    }
    
    func setupMainView() {
        let postView = PostView(frame: self.view.frame)
        self.mainView = postView
        self.mainView.dismissAction = self.dismissController
        self.mainView.plusPhotoAction = self.handleAddPhoto
        view.addSubview(mainView)
        mainView.pinEdges(to: self.view)
    }
    
    func handleAddPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func setupNavigationButtons() {
        let backImage = UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal)
        let backButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self,
                                             action: #selector(dismissController))
        navigationItem.leftBarButtonItems = [backButtonItem]
        let sentImage = UIImage(named: "sent")?.withRenderingMode(.alwaysOriginal)
        let sentButtonItem = UIBarButtonItem(image: sentImage, style: .plain, target: self,
                                             action: #selector(handlePost))
        navigationItem.rightBarButtonItems = [sentButtonItem]
    }
    
    func handlePost() {
        print("sent")
    }
    
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            mainView.addButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            mainView.addButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
