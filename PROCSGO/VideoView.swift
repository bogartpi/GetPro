//
//  VideoView.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 1/09/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoView: BaseView {
    
    var player: AVPlayer!
    
    let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.8
        return blurView
    }()
    
    override func setupViews() {
        super.setupViews()
        setup()
    }
    
    func setup() {
        setupVideo()
        setupBlurView()
        NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseVideo), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playVideo), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    func setupBlurView() {
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        blurEffectView.pinEdges(to: self)
    }
    
    func setupVideo() {
        let videoUrl: URL = Bundle.main.url(forResource: "video", withExtension: "mov")!
        player = AVPlayer(url: videoUrl)
        player.actionAtItemEnd = .none
        player.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = self.frame
        self.layer.addSublayer(playerLayer)
        player.play()
        player.rate = 0.6
    }
    
    func loopVideo() {
        player.seek(to: kCMTimeZero)
        player.play()
    }
    
    func pauseVideo() {
        player.pause()
    }
    
    func playVideo() {
        player.play()
    }
}
