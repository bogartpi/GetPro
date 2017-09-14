//
//  NewsPostView.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 11/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class PostView: BaseView {
    
    override func setupViews() {
        super.setupViews()
        setup()
    }
    
    var dismissAction: (() -> Void)?
    var plusPhotoAction: (() -> Void)?
    
    func setup() {
        hideKeyboardWhenTappedAround()
        descriptionTextView.delegate = self
        self.backgroundColor = UIColor.customGrayColor
        self.addSubview(scrollView)
        scrollView.addSubview(addButton)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(descriptionTextView)
        
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        addButton.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: self.frame.size.width - 40, height: 200)
        titleTextField.anchor(top: addButton.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 50)
        descriptionTextView.anchor(top: titleTextField.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: -20, paddingRight: 20)
    }
    
    func handleAddPhoto() {
        plusPhotoAction?()
    }
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.isScrollEnabled = true
        return sv
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusPhoto").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 0.6, alpha: 0.8)
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        button.backgroundColor = UIColor.customDarkGrayColor
        button.setDefaultShadow()
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.customDarkGrayColor
        textField.anchor(width: 0, height: 50)
        textField.setLeftPaddingPoints(20)
        let placeholder = NSAttributedString(string: "News Title",
                                             attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 15)])
        textField.attributedPlaceholder = placeholder
        textField.setDefaultShadow()
        textField.autocorrectionType = .no
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.customDarkGrayColor
        textView.anchor(width: 0, height: 150)
        textView.text = "News Description"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        textView.autocorrectionType = .no
        textView.setDefaultShadow()
        return textView
    }()

}
