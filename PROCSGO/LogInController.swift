//
//  LogInController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 30/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class LogInController: UIViewController {
    
    var videoView: VideoView!
    var mainView: LoginMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        setupVideoView()
        setupMainView()
    }
    
    func setupVideoView() {
        let videoView = VideoView(frame: self.view.frame)
        self.videoView = videoView
        self.view.addSubview(videoView)
        videoView.pinEdges(to: self.view)
    }
    
    func setupMainView() {
        let mainView = LoginMainView(frame: self.view.frame)
        self.mainView = mainView
        self.mainView.signUpAction = self.signUpSwitch
        self.videoView.addSubview(mainView)
        mainView.pinEdges(to: self.videoView)
    }
    
    func signUpSwitch() {
        print(123)
    }
}
