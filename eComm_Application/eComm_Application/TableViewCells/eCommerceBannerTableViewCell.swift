//
//  eCommerceBannerTableViewCell.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

class eCommerceBannerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var sampleBackgroundView: UIView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var bannerImageView: UIImageView! {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupBannerImageView(itemModels: Content) {
        
        let imageUrl1 = URL(string: itemModels.bannerImage!)!
        let imageData1 = try! Data(contentsOf: imageUrl1)
        let firstImage = UIImage(data: imageData1)
        bannerImageView.image = firstImage
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


