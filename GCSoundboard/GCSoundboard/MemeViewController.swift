//
//  MemeViewController.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 14/09/2019.
//  Copyright © 2019 Kieran. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let memeBank: [UIImage?] = [
        UIImage(named: "meme1"),
        UIImage(named: "meme2"),
        UIImage(named: "meme3"),
        UIImage(named: "meme4"),
        UIImage(named: "meme5"),
        UIImage(named: "meme6"),
        UIImage(named: "meme7"),
        UIImage(named: "meme8"),
        UIImage(named: "meme9"),
        UIImage(named: "meme10"),
        UIImage(named: "meme11"),
        UIImage(named: "meme12"),
        UIImage(named: "meme13"),
        UIImage(named: "meme14"),
        UIImage(named: "meme15"),
        UIImage(named: "meme16"),
        UIImage(named: "meme17"),
        UIImage(named: "meme18"),
        UIImage(named: "meme19"),
        UIImage(named: "meme20"),
        UIImage(named: "meme21"),
        UIImage(named: "meme22"),
        UIImage(named: "meme23"),
        UIImage(named: "meme24")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupBackground()
        setupAdBanner()
        
        self.collectionView.register(UINib(nibName: "MemeCell", bundle: nil), forCellWithReuseIdentifier: MemeCell.CELL_ID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeBank.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCell.CELL_ID, for: indexPath) as! MemeCell
                cell.setup(image: memeBank[indexPath.row]!)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// Todo:
// Interstitual ad
