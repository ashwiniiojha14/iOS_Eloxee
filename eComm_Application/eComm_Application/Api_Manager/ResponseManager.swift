//
//  ResponseManager.swift
//  eComm_Application
//
//  Created by Ashwinii Ojha on 02/03/20.
//  Copyright © 2020 Ashwinii Ojha. All rights reserved.
//

import Foundation

class ResponseManager: NSObject {
    
    class func callItemsList(CompletionHandeler: @escaping ((_ gotData: Bool) -> Void)) {
        DispatchQueue.main.async {
            guard let url = URL(string: "https://api.myjson.com/bins/chou4") else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    
                    let decoder = JSONDecoder()
                    let checkData = try decoder.decode(ResponseModel.self, from: data!)
                    ResponsiveSingleton.shared.responseContentModel = checkData.content
                    
                    CompletionHandeler(true)
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }
    }
    
    
    // Used to fetch data from local json file if URL fails
    
    class func getProducts(completion: @escaping (_ gotData: Bool) -> Void){
        
        if let path = Bundle.main.url(forResource: "Product_List", withExtension: "json") {
            do{
                let data = try Data(contentsOf: path)
                let decoder = JSONDecoder()
                let checkData = try decoder.decode(ResponseModel.self, from: data)
                ResponsiveSingleton.shared.responseContentModel = checkData.content
                completion(true)
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}


