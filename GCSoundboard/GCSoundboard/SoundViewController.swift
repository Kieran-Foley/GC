//
//  ViewController.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 24/05/2018.
//  Copyright © 2018 Kieran. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SoundViewController: UIViewController, GADBannerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Actual AdMob Key = ca-app-pub-1725298510457190/7205116574
    private static let AD_UNIT_ID: String = "ca-app-pub-3940256099942544/2934735716"
    
    private static let SOUNDEFFECTS: [Soundeffect] = [
        Soundeffect.init(name: "Involved", sound: "involved"),
        Soundeffect.init(name: "Be Me", sound: "beMe"),
        Soundeffect.init(name: "Candy", sound: "candy"),
        Soundeffect.init(name: "Serious", sound: "Serious"),
        Soundeffect.init(name: "You Do\nIt Hun", sound: "Hun"),
        Soundeffect.init(name: "Gemma", sound: "Gemma"),
        Soundeffect.init(name: "Dictionary", sound: "dictionary"),
        Soundeffect.init(name: "Frazzled", sound: "Frazzled"),
        Soundeffect.init(name: "I'm\nOff", sound: "I'mOff"),
        Soundeffect.init(name: "Arsehole", sound: "Arsehole"),
        Soundeffect.init(name: "Money", sound: "Money"),
        Soundeffect.init(name: "Cloned", sound: "Cloned"),
        Soundeffect.init(name: "Absolute\nBell*nd", sound: "Bell"),
        Soundeffect.init(name: "Cyah\nLater", sound: "Cyah"),
        Soundeffect.init(name: "Games", sound: "Games"),
        Soundeffect.init(name: "NO!", sound: "No"),
        Soundeffect.init(name: "Don't\nGet It!", sound: "Claustrophobic"),
        Soundeffect.init(name: "Talking", sound: "Talking"),
        Soundeffect.init(name: "24/7", sound: "247"),
        Soundeffect.init(name: "Gillian", sound: "Gillian"),
        Soundeffect.init(name: "Suffer", sound: "Suffer"),
        Soundeffect.init(name: "Cheap\nClothes", sound: "CheapClothes"),
        Soundeffect.init(name: "Me\nAgain", sound: "SaidMeAgain"),
        Soundeffect.init(name: "Shut Your\nMouth", sound: "ShutYourMouth")
]
    
    private static let CELLS_PER_ROW: CGFloat = 3
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stackView: UIStackView!
    
    // Stops all sound from audio player
    @IBOutlet weak var stopSoundButton: UIButton!
    
    // Plays a random sound from SOUNDEFFECTS
    @IBOutlet weak var randomButton: UIButton!
    
    var bannerView: GADBannerView!
    
    var cellSpacing: CGFloat?
    var cellDimensions: CGFloat?
    
    override func viewDidLoad() {
        setupBackground()
        
        AdManager.SINGLETON.createAndLoadInterstitial()
        
        // Stops the default animation of UIButton when user interacts (Grey highlight)
        self.stopSoundButton.adjustsImageWhenHighlighted = false
        self.randomButton.adjustsImageWhenHighlighted = false
        
        // adMob
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = SoundViewController.AD_UNIT_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Setup random / stop sound button cells
        stopSoundButton.backgroundColor = UIColor.clear
        randomButton.backgroundColor = UIColor.clear
        stopSoundButton.layer.borderWidth = 7
        randomButton.layer.borderWidth = 7
        stopSoundButton.layer.borderColor = UIColor.white.cgColor
        randomButton.layer.borderColor = UIColor.white.cgColor
        
        // Button labels
        stopSoundButton.setTitle("Stop\nSound", for: .normal)
        randomButton.setTitle("Random\nSound", for: .normal)
        stopSoundButton.titleLabel?.numberOfLines = 2
        randomButton.titleLabel?.numberOfLines = 2
        stopSoundButton.titleLabel?.textAlignment = .center
        randomButton.titleLabel?.textAlignment = .center
        
        if UIScreen.main.bounds.width == 320.0 {
            stopSoundButton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Bold", size: 16)
            randomButton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Bold", size: 16)
        } else {
            stopSoundButton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Bold", size: 18)
            randomButton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Bold", size: 18)
        }
    }

    // FIXME: Shouldn't be changing layouts at runtime
    override func viewDidAppear(_ animated: Bool) {
        stopSoundButton.layer.cornerRadius = stopSoundButton.frame.width / 2
        randomButton.layer.cornerRadius = randomButton.frame.width / 2
    }

    // Set adMob banners constraints to safe area
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        bannerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupBackground() {
        let gradient = CAGradientLayer()
        
        // Create a gradient at 3/4 down the view
        gradient.locations = [0.75, 1]
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.CG_PINK.cgColor, UIColor.white.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    // Stop all current sounds playing and animate button
    @IBAction func stopSoundButton(_ sender: Any) {
        AudioManager.singleton.stopAll()
        self.stopSoundButton.spin()
    }
    
    // Play a random sound / animate button
    @IBAction func randomButton(_ sender: Any) {
        self.randomButton.spin()
        
        // Gets the amount of sounds in instance
        let count = UInt32(SoundViewController.SOUNDEFFECTS.count)
        // Gets a random number between 0 and count
        let randomNum:Int = Int(arc4random_uniform(count))
        let sound = SoundViewController.SOUNDEFFECTS[randomNum]
        
        AudioManager.singleton.playSound(name: (sound.soundPath))
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Setup the cell dimensions and spacing ONCE
        if cellSpacing == nil && cellDimensions == nil {
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                cellSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
                cellDimensions = (collectionView.frame.width - max(0, SoundViewController.CELLS_PER_ROW - 1) * cellSpacing!) / SoundViewController.CELLS_PER_ROW
                
                flowLayout.itemSize = CGSize(width: cellDimensions!, height: cellDimensions!)
                
                // Button spacing in stack view == Cell spacing
                stackView.spacing = cellSpacing!
                
                // Cell constaints
                stopSoundButton.widthAnchor.constraint(equalToConstant: cellDimensions!).isActive = true
                stopSoundButton.heightAnchor.constraint(equalToConstant: cellDimensions!).isActive = true
                randomButton.widthAnchor.constraint(equalToConstant: cellDimensions!).isActive = true
                randomButton.heightAnchor.constraint(equalToConstant: cellDimensions!).isActive = true
            }
        }
        // Return the amount of cells == sounds
        return SoundViewController.SOUNDEFFECTS.count
    }
    
    // Assign image / sound to each cell and add a gesture recogniser to animate / play sound
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundeffectCell.CELL_ID, for: indexPath) as! SoundeffectCell
        cell.setup(SoundViewController.SOUNDEFFECTS[indexPath.row])
        cell.addGestureRecognizer(UITapGestureRecognizer(target: cell, action: #selector(SoundeffectCell.tap)))
        return cell
    }
}

/*  ToDo:
*   Fix layout issues (Cell rendering should not be in viewDidAppear)
*
*/
