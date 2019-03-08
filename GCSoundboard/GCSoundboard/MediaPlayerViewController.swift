//
//  MediaPlayerViewController.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 07/03/2019.
//  Copyright © 2019 Kieran. All rights reserved.
//

import UIKit
import AVKit

class MediaPlayerViewController: UIViewController {

    @IBOutlet weak var mediaView: UIView!
    
    let avpController = AVPlayerViewController()
    let player = AVPlayer()?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "loveIsland", ofType:"mp4") else {
            debugPrint("video.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        avpController.player = player
        let playerLayerAV = AVPlayerLayer(player: player)

        playerLayerAV.frame = mediaView.bounds
        
        mediaView.layer.addSublayer(playerLayerAV)
        player.play()
    }
    
    
    
    @IBAction func pressed(_ sender: Any) {
        playVideo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
