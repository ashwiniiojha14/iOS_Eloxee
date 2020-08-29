//
//  OrdersTableViewCell.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 08/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addOrderItems(indexItem: Int) {
        nameLabel.text = ResponsiveSingleton.shared.orderList[indexItem].item_Name
        orderID.text = "Order Id: \(ResponsiveSingleton.shared.orderList[indexItem].order_Id!)"
    }
    
}
