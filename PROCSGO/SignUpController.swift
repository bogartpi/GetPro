//
//  SignUpController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 30/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    var videoView: VideoView!
    var mainView: SignUpMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        setupMainView()
    }

    func setupMainView() {
        let mainView = SignUpMainView(frame: self.view.frame)
        self.mainView = mainView
        self.mainView.dismissAction = self.dismissController
        view.addSubview(mainView)
        mainView.pinEdges(to: self.view)
    }
    
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
