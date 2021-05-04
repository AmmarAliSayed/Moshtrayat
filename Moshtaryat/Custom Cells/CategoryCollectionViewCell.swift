//
//  CategoryCollectionViewCell.swift
//  Moshtaryat
//
//  Created by Macbook on 17/04/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    func generateCell(_ category : Category){
        categoryLabel.text = category.name
        categoryImageView.image = category.image
    }
}
