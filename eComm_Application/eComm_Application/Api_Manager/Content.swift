//
//  Content.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import Foundation

struct Content: Decodable {
    let sectionType: String?
    let name: String?
    let bannerImage: String?
    let firstImage: String?
    let secondImage: String?
    let products: [Products]?
}
