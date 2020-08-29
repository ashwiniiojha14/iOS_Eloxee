//
//  CartData.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 06/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import Foundation

class CartData {
    
    var item_Name: String?
    var item_Price: String?
    var item_URL: String?
    var item_Type: String?
    
    
    init(cartItem_Name: String, cartItem_Price: String, cartItem_URL: String, cartItem_Type: String) {
        self.item_Name = cartItem_Name
        self.item_Price = cartItem_Price
        self.item_URL = cartItem_URL
        self.item_Type = cartItem_Type
    }
}
