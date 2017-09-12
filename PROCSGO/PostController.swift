//
//  NewsPostController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 11/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class PostController: UIViewController {
    
    var mainView: PostView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
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
        guard let image = mainView.addButton.currentImage else { return }
        print(image)
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        print(uploadData)
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("news_Images").child(filename).putData(uploadData, metadata: nil) { (metadata, error) in
            if let err = error {
                print("Failed to upload post image:", err.localizedDescription)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
            print("Successfully uploaded an image:", imageUrl)
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
        }
    }
    
    func saveToDatabaseWithImageUrl(imageUrl: String) {
        guard let postImage = mainView.addButton.currentImage else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            return print("Not selected PostImage")
        }
        guard let title = mainView.titleTextField.text, title.characters.count > 0 else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            return print("Not entered title")
        }
        guard let descriptionText = mainView.descriptionTextView.text, descriptionText != "News Description", descriptionText.characters.count > 0 else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            return print("Not entered description text")
        }
        let creationDate = Date().timeIntervalSince1970
        
        let postRef = Database.database().reference().child("posts")
        let postId = postRef.childByAutoId()
        let values = ["imageUrl": imageUrl,
                      "imageWith": postImage.size.width,
                      "imageHeight": postImage.size.height,
                      "title": title,
                      "body": descriptionText,
                      "creationDate": creationDate] as [String : Any]
        postId.updateChildValues(values) { (error, ref) in
            if let err = error {
                print("Failed to save post to DB:", err.localizedDescription)
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                return
            }
            print("Successully saved post to DB")
            self.dismiss(animated: true, completion: nil)
        }
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
