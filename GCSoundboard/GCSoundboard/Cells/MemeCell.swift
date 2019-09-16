//
//  MemeCell.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 14/09/2019.
//  Copyright © 2019 Kieran. All rights reserved.
//

import UIKit

class MemeCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    static let CELL_ID: String = "meme_cell"
    
    @IBOutlet weak var imageView: UIImageView!

    func setup(image: UIImage) {
        imageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
