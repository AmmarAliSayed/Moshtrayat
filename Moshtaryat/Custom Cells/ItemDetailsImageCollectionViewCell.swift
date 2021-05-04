//
//  ItemDetailsImageCollectionViewCell.swift
//  Moshtaryat
//
//  Created by Macbook on 21/04/2021.
//

import UIKit

class ItemDetailsImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    func setupImageWith(itemImage: UIImage) {
        
        itemImageView.image = itemImage
    }
}
