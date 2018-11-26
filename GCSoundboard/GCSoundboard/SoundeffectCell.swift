//
//  CollectionViewCell.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 20/06/2018.
//  Copyright © 2018 Kieran. All rights reserved.
//

import UIKit

class SoundeffectCell: UICollectionViewCell {
    
    // RE-USE Identifier
    static let CELL_ID: String = "soundeffectCell"
    
    let nameLabel: UILabel = UILabel()
    
    var soundeffect: Soundeffect?

    func setup(_ soundeffect: Soundeffect) -> Void {
        self.soundeffect = soundeffect
        
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 7
        self.layer.cornerRadius = self.frame.width / 2
        
        if UIScreen.main.bounds.width == 320.0 {
            self.nameLabel.font = UIFont(name:"ChalkboardSE-Bold", size: 15.0)
        } else {
            self.nameLabel.font = UIFont(name:"ChalkboardSE-Bold", size: 18.0)
        }
        
        let attributedString = NSMutableAttributedString(string: soundeffect.soundName)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.nameLabel.numberOfLines = 2
        self.nameLabel.attributedText = attributedString
        self.nameLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.nameLabel.textAlignment = .center
        self.nameLabel.textColor = UIColor.white
        self.addSubview(self.nameLabel)
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        self.spin()
        AudioManager.singleton.playSound(name: (soundeffect?.soundPath)!)
        randomAd()
    }
    
    func randomAd() {
        let number = Int.random(in: 0 ... 5)
        if number == 5 {
            AdManager.SINGLETON.showAd()
        }
    }
}
