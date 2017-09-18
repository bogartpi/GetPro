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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comments"
        collectionView?.backgroundColor = UIColor.white 
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .interactive
    
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        
        collectionView?.register(CommentsCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchComments()
    }
    
    func handleInputChange() {
        let isFormValid = commentTextField.text?.characters.count ?? 0 > 0 &&
            !((commentTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!)
        if isFormValid {
            submitButton.isEnabled = true
            sendImage.image = UIImage(named: "send_enabled")?.withRenderingMode(.alwaysOriginal)
        } else {
            submitButton.isEnabled = false
            sendImage.image = UIImage(named: "send_disabled")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    fileprivate func fetchComments() {
        guard let postId = post?.id else { return }
        
        let ref = Database.database().reference().child("comments").child(postId)
        
        ref.observe(.childAdded, with: { (snapshot) in
            
            guard let dict = snapshot.value as? [String: Any] else { return }
            guard let uid = dict["uid"] as? String else { return }
            
            Database.fetchUserWithUID(uid: uid, completion: { (user) in
                let comment = Comment(user: user, dictionary: dict)
                self.comments.append(comment)
                self.collectionView?.reloadData()
            })
            
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
            
            self.commentTextField.text = ""
            self.sendImage.image = UIImage(named: "send_disabled")?.withRenderingMode(.alwaysOriginal)
            self.submitButton.isEnabled = false
        }
        
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.customGrayColor
        separatorView.alpha = 0.1
        
        containerView.addSubview(self.submitButton)
        containerView.addSubview(self.commentTextField)
        containerView.addSubview(separatorView)
        self.submitButton.addSubview(self.sendImage)
        
        separatorView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        self.submitButton.anchor(top: containerView.topAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 30, height: 0)
        
        self.sendImage.centerYAnchor.constraint(equalTo: self.submitButton.centerYAnchor).isActive = true
        self.sendImage.centerXAnchor.constraint(equalTo: self.submitButton.centerXAnchor).isActive = true
        self.sendImage.anchor(width: 30, height: 30)
        
        self.commentTextField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: self.submitButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        
        return containerView
    }()
    
    
    let sendImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "send_disabled")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        var placeholder = NSMutableAttributedString()
        let attributes: [String: Any] = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15)!,
                                         NSForegroundColorAttributeName : UIColor(white: 0.3, alpha: 0.7)]
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Enter Comment",
                                                                                     attributes: attributes))
        textField.attributedPlaceholder = placeholder
        textField.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        return textField
    }()
    
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
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let flexyCell = CommentsCell(frame: frame)
        flexyCell.comment = comments[indexPath.item]
        flexyCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = flexyCell.systemLayoutSizeFitting(targetSize)
        
        let height = max(56, estimatedSize.height)
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
