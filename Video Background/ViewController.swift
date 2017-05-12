//
//  ViewController.swift
//  Video Background
//
//  Created by Kai Schaller on 3/11/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the video from the app bundle.
        let videoURL: URL = Bundle.main.url(forResource: "video", withExtension: "mov")!
        
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1

        playerLayer.frame = view.frame

        view.layer.addSublayer(playerLayer)

        player?.play()
            
        //loop video
        NotificationCenter.default.addObserver(self,
            selector: #selector(ViewController.loopVideo),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil)
     }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }

}

