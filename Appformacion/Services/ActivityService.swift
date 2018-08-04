//
//  ActivityService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 26/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import UIKit

class ActivityService {
    
    static func getActivities(register: String, completionHandler: @escaping ([ActividadesProgramadas]) -> ()) {
        let headers = ["registro":"\(register)"]
        
        let url = URL(string: Constants.WEBSERVICE.activities)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let activities = try JSONDecoder().decode(Activity.self, from: response.data!)
                            completionHandler((activities.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                            completionHandler([ActividadesProgramadas]())
                        }
                    }
                }
            }
        }
    }
    
    static func getDetails(grupoPersonaId: Int, completionHandler: @escaping ([ActividadDetalle]) -> ()) {
        let headers = ["grupoPersonaId":"\(grupoPersonaId)"]
        
        let url = URL(string: Constants.WEBSERVICE.activitiesDetails)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let details = try JSONDecoder().decode(ActivityDetail.self, from: response.data!)
                            completionHandler((details.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                }
            }
        }
    }
    
}
