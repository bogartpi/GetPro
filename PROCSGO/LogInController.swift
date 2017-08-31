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
    var mainView: MainView!
    
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
        let mainView = MainView(frame: self.view.frame)
        self.mainView = mainView
        self.videoView.addSubview(mainView)
        mainView.pinEdges(to: self.videoView)
    }
}

class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
