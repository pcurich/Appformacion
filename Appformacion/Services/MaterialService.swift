//
//  MaterialService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 30/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import UIKit

class MaterialService {
    
    static func getMaterials(register: String, completionHandler: @escaping ([MaterialDetail]) -> ()) {
        let headers = ["registro":"\(register)"]
        
        let url = URL(string: Constants.WEBSERVICE.materials)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let assistence = try JSONDecoder().decode(Material.self, from: response.data!) 
                            completionHandler((assistence.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                            completionHandler([MaterialDetail]())
                        }
                    }
                }
            }
        }
    }
    
}
