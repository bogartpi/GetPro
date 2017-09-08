//
//  SignUpMainView.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 2/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class SignUpMainView: BaseView {
    
    var dismissAction: (() -> Void)?
    var plusPhotoAction: (() -> Void)?
    var signUpAction: (() -> Void)?
    var inputChangeAction: (() -> Void)?
    
    let closeButton: UIButton = {
        let button = UIButton(imageName: "back")
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusPhoto").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 0.6, alpha: 0.8)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        button.layer.cornerRadius = 60
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.6, alpha: 0.8).cgColor
        button.layer.masksToBounds = true
        button.anchor(width: 120, height: 120)
        return button
    }()
    
    let userNameTextField: UITextField = {
        let tf = UITextField(placeHolderName: "Username", leftViewImage: "user_", plusWidth: 25)
        tf.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField(placeHolderName: "Email", leftViewImage: "email_", plusWidth: 25)
        tf.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf =  UITextField(placeHolderName: "Password", leftViewImage: "pwicon_", plusWidth: 30)
        tf.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Sign Up", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.white])
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor.customRedColor
        button.alpha = 0.5
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.white])
        let rightAttributedString = NSMutableAttributedString(string: "Sign In", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Black", size: 13) ?? UIFont.boldSystemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.white])
        attributedString.append(rightAttributedString)
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.alpha = 0.6
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        hideKeyboardWhenTappedAround()
        setup()
    }
    
    // MARK: - UI
    func setup() {
        let containerStack = containterStackView()
        let alreadyHaveAccountButtonStack = alreadyHaveAccountButtonStackView()
        addSubview(closeButton)
        addSubview(containerStack)
        addSubview(alreadyHaveAccountButtonStack)

        closeButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        containerStack.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
        containerStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerStack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        alreadyHaveAccountButtonStack.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                                             paddingTop: 0, paddingLeft: 12, paddingBottom: -12, paddingRight: 12,
                                             width: 0, height: 20)
    }
    
    func containterStackView() -> UIStackView {
        let inputFieldsStack = inputFieldsStackView()
        let stackView = UIStackView(arrangedSubviews: [plusButton, inputFieldsStack])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 30
        stackView.alignment = .center
        return stackView
    }
    
    func inputFieldsStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, emailTextField, passwordTextField, signUpButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.anchor(width: self.frame.width - 60, height: 0)
        return stackView
    }
    
    func alreadyHaveAccountButtonStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [alreadyHaveAccountButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }
    
    func dismissController() {
        dismissAction?()
    }
    
    func handlePlusPhoto() {
        plusPhotoAction?()
    }
    
    func handleSignUp() {
        signUpAction?()
    }
    
    func handleInputChange() {
        inputChangeAction?()
    }

}
