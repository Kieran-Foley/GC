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
    static let PLAYER = AVPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
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
    
    func setupBackground() {
        let gradient = CAGradientLayer()
        mediaView.backgroundColor = .CG_PINK
        
        // Create a gradient at 3/4 down the view
        gradient.locations = [0.75, 1]
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.CG_PINK.cgColor, UIColor.white.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
    }
    
    
    @IBAction func pressed(_ sender: Any) {
        playVideo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
