//
//  AssistanceService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 29/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import UIKit

class AssistanceService {
    
    static func getAssistances(register: String, completionHandler: @escaping ([AssistanceLine]) -> ()) {
        let headers = ["registro":"\(register)"] //, "fechaFormato":"20180608"
        
        let url = URL(string: Constants.WEBSERVICE.assistences)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let assistence = try JSONDecoder().decode(Assistance.self, from: response.data!)
                            completionHandler((assistence.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                }
            }
        }
    }
    
    static func getAssistanceDetails(register: String, salaId: Int, completionHandler: @escaping ([AssistanceDetailLine]) -> ()) {
        let headers = ["registro":"\(register)", "salaId":"\(salaId)"] //, "fechaFormato":"20180608"
        
        let url = URL(string: Constants.WEBSERVICE.assistenceDetails)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let assistence = try JSONDecoder().decode(AssistanceDetail.self, from: response.data!)
                            completionHandler((assistence.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                            completionHandler([AssistanceDetailLine]())
                        }
                    }
                }
            }
        }
    }
    
    static func checkIn(code:String, grpdId: Int, completionHandler: @escaping (CheckIn) -> ()) {
        let headers = ["grpdId":"\(grpdId)",
                        "codigoAsistencia":code]
        
        let url = URL(string: Constants.WEBSERVICE.checkIn)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let checkIn = try JSONDecoder().decode(CheckIn.self, from: response.data!)
                            completionHandler(checkIn)
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                }
            }
        }
    }
}
