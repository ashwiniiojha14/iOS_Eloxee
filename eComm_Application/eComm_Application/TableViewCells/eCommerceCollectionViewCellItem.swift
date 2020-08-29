//
//  eCommerceCollectionViewCellItem.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

class eCommerceCollectionViewCellItem: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var typeLabel: UILabel! {
        didSet {
            
        }
    }

    func setupItemsInsideCells(itemModels: Products) {
        nameLabel.text = itemModels.name
        priceLabel.text = itemModels.price
        typeLabel.text = itemModels.type
        
        let imageUrl = URL(string: itemModels.imageURL!)!
        let imageData = try! Data(contentsOf: imageUrl)
        let thumImage = UIImage(data: imageData)
        imageViewCell.image = thumImage
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
