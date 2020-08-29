//
//  eCommerceSplitTableViewCell.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

class eCommerceSplitTableViewCell: UITableViewCell {

    @IBOutlet weak var sampleBackgroundView: UIView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var firstImageView: UIImageView! {
        didSet {
            firstImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var secondImageView: UIImageView! {
        didSet {
            secondImageView.clipsToBounds = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupSplitView(itemModels: Content) {
        
        let imageUrl1 = URL(string: itemModels.firstImage!)!
        let imageData1 = try! Data(contentsOf: imageUrl1)
        let firstImage = UIImage(data: imageData1)
        firstImageView.image = firstImage
        
        let imageUrl2 = URL(string: itemModels.secondImage!)!
        let imageData2 = try! Data(contentsOf: imageUrl2)
        let secondImage = UIImage(data: imageData2)
        secondImageView.image = secondImage
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
