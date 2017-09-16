//
//  CommentsController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 17/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class CommentsController: UICollectionViewController {
    
    let cellId = "cellId"
    
    var post: Post?
    
    var comments = [Comment]()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.customWhitecolor
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.customDarkGrayColor, for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        
        containerView.addSubview(submitButton)
        submitButton.anchor(top: containerView.topAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 70, height: 0)
        
        containerView.addSubview(self.commentTextField)
        self.commentTextField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: submitButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        return containerView
    }()
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        var placeholder = NSMutableAttributedString()
        let attributes: [String: Any] = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15)!,
                                         NSForegroundColorAttributeName : UIColor(white: 0.5, alpha: 0.7)]
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Enter Comment",
                                                                                     attributes: attributes))
        textField.attributedPlaceholder = placeholder
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comments"
        collectionView?.backgroundColor = UIColor.customGrayColor
    
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        
        collectionView?.register(CommentsCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchComments()
    }
    
    func fetchComments() {
        guard let postId = post?.id else { return }
        let ref = Database.database().reference().child("comments").child(postId)
        ref.observe(.childAdded, with: { (snapshot) in
            
            guard let dict = snapshot.value as? [String: Any] else { return }
            let comment = Comment(dictionary: dict)
            self.comments.append(comment)
            self.collectionView?.reloadData()
        }) { (error) in
            print("Failed to observe comments")
        }
    }

    func handleSubmit() {
        guard let postId = post?.id else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = ["text": commentTextField.text ?? "",
                      "createDate": Date().timeIntervalSince1970,
                      "uid": uid] as [String : Any]
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (error, ref) in
            if let err = error {
                print("Failed to insert the comment", err.localizedDescription)
                return
            }
            
            print("Successfully inserted comment")
        }
        
    }
    
}

extension CommentsController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}

extension CommentsController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentsCell
        cell.comment = comments[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: -58, right: 0)
    }
}
