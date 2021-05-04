//
//  ItemTableViewCell.swift
//  Moshtaryat
//
//  Created by Macbook on 20/04/2021.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func generateCell(_ item: Item) {
        
        nameLabel.text = item.name
        descriptionLabel.text = item.description
      //  priceLabel.text = "\(item.price!)"
        priceLabel.text = convertToCurrency(item.price)
        //beacause sometimes the price is so big
        priceLabel.adjustsFontSizeToFitWidth = true
        
        if item.imageLinks != nil && item.imageLinks.count > 0 {
            downloadImagesFromFirebase(imageUrls: [item.imageLinks.first!]) { (images) in
                DispatchQueue.main.async {
                    self.itemImageView.image = images.first as? UIImage
                }
                
            }
        }
    }
    

}

