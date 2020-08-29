//
//  OrderData.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 08/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import Foundation

class OrdersData {
    
    var item_Name: String?
    var order_Id: String?
    
    
    init(orderrItem_Name: String, orderItem_ID: String) {
        self.item_Name = orderrItem_Name
        self.order_Id = orderItem_ID
    }
}
