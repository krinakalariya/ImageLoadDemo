//
//  ImageCell.swift
//  PracticleTest
//
//  Created by Shyam Dineshbhai Kalariya on 14/04/24.
//

import UIKit

class ImageCell: UICollectionViewCell {

    static let id = "ImageCell"
    
    @IBOutlet weak var imgV: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgV.layer.cornerRadius = 6
        // Initialization code
    }

}
