//
//  ResponsiveSingleton.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import Foundation

final class ResponsiveSingleton {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = ResponsiveSingleton()
    
    var responseContentModel: [Content]?
    
    var cartList = [CartData]()
    var orderList = [OrdersData]()

}
