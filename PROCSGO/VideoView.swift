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

class VideoView: UIView {
    
    var player: AVPlayer!
    
    let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.8
        return blurView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        setupVideo()
        setupBlur()
        NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func setupBlur() {
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
