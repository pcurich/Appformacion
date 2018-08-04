//
//  DashboardService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 3/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class DashboardService {
    
    static func getDashboard(register: String, completionHandler: @escaping ([Dashboard]) -> ()) {
        let headers = ["registro":"\(register)"]
        
        let url = URL(string: Constants.WEBSERVICE.dashboard)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let dashboards = try JSONDecoder().decode(DashboardInfo.self, from: response.data!)
                            completionHandler((dashboards.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                }
            }
        }
    }
}
