//
//  LoginMainView.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 1/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class LoginMainView: BaseView {

    var signUpAction: (() -> Void)?
    
    let welcomeLabel: UILabel = {
        let label = UILabel(topTitle: "GetPro\n", topFont: UIFont(name: "Avenir-Heavy", size: 35) ?? UIFont.boldSystemFont(ofSize: 35),
                            topColor: UIColor(white: 0.9, alpha: 0.8), bottomTitle: "The best place to get know CSGO World",
                            bottomFont: UIFont(name: "Avenir-Heavy", size: 12) ?? UIFont.systemFont(ofSize: 12), bottomColor: UIColor(white: 0.9, alpha: 0.8), align: NSTextAlignment.center)
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField(placeHolderName: "Email", leftViewImage: "email_", plusWidth: 25)
        tf.anchor(width: 0, height: 40)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf =  UITextField(placeHolderName: "Password", leftViewImage: "pwicon_", plusWidth: 30)
        tf.isSecureTextEntry = true
        tf.anchor(width: 0, height: 40)
        return tf
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Sign In", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.white])
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor(r: 73, g: 144, b: 226)
        button.alpha = 0.5
        button.layer.cornerRadius = 3
        button.anchor(width: 0, height: 40)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Forgot Password? ",
                                                         attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12),
                                                                      NSForegroundColorAttributeName: UIColor.white])
        let rightAttributedString = NSMutableAttributedString(string: "Reset", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Black", size: 13) ?? UIFont.boldSystemFont(ofSize: 13),
                                                                                            NSForegroundColorAttributeName: UIColor.white])
        attributedString.append(rightAttributedString)
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.alpha = 0.6
        button.anchor(width: 0, height: 10)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Don't have an account yet? ", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.white])
        let rightAttributedString = NSMutableAttributedString(string: "Sign Up", attributes: [NSFontAttributeName: UIFont(name: "Avenir-Black", size: 13) ?? UIFont.boldSystemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.white])
        attributedString.append(rightAttributedString)
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.alpha = 0.6
        button.addTarget(self, action: #selector(switchToSignUp), for: .touchUpInside)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        hideKeyboardWhenTappedAround()
        backgroundColor = .clear
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setup()
    }
    
    func switchToSignUp(sender: UIButton) {
        signUpAction?()
    }
    
    func setup() {
        let containerStackView = welcomeAndInputStackView()
        let bottomStackView = resetAndSignupStackView()
        
        addSubview(containerStackView)
        addSubview(bottomStackView)
        
        containerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerStackView.anchor(width: self.frame.width - 60, height: 290)
        bottomStackView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                               paddingTop: 0, paddingLeft: 12, paddingBottom: -12, paddingRight: 12,
                               width: 0, height: 20)
    }
    
    func welcomeAndInputStackView() -> UIStackView {
        let welcomeStack = welcomeStackView()
        let inputStack = inputStackView()
        let stackView = UIStackView(arrangedSubviews: [welcomeStack, inputStack])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 50
        return stackView
    }
    
    func welcomeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.anchor(width: 0, height: 80)
        return stackView
    }
    
    func inputStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signInButton, resetButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }
    
    func resetAndSignupStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [signUpButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }

}
