//
//  AudioController.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 24/05/2018.
//  Copyright © 2018 Kieran. All rights reserved.
//

import AVFoundation
import UIKit

class AudioManager {
    
    // Only one class of AudioManager is instantiated
    static let singleton = AudioManager()
    var player: AVAudioPlayer?
    
  func playSound(name:String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
    
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    // Stop all sounds.
    func stopAll() {
        player?.stop()
    }

    // Play a random sound.
    func randomNo(sounds:[String]) {
        let random = sounds[Int(arc4random_uniform(UInt32(sounds.count)))]
        playSound(name: random)
    }
}

