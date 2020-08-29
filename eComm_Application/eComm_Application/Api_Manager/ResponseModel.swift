//
//  ResponseModel.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import Foundation

struct ResponseModel: Decodable {
    
    let code: String?
    let content: [Content]?
    
    
    enum CodingKeys: String, CodingKey {
        case code, content
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try values.decodeIfPresent(String.self, forKey: .code)
        content = try values.decodeIfPresent([Content].self, forKey: .content)
    }
}
