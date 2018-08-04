//
//  EvaluationService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 8/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import UIKit

class EvaluationService {
    
    static func getEvaluations(register: String, completionHandler: @escaping ([EvaluationList]) -> ()) {
        let headers = ["registro":"\(register)"]//,"fechaFormato":"20180724"
        
        let url = URL(string: Constants.WEBSERVICE.evaluations)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
            if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                if response.data != nil {
                    do {
                        let assistence = try JSONDecoder().decode(Evaluations.self, from: response.data!)
                        DispatchQueue.main.async {
                            if(assistence.body == nil){
                                completionHandler([EvaluationList]())
                            }else{
                                completionHandler(assistence.body!)
                            }
                        }
                    }catch let error as NSError {
                        print(error.description)
                        DispatchQueue.main.async {
                            completionHandler([EvaluationList]())
                        }
                    }
                }
            }
        }
    }
    
    static func save(grppId: Int,respuestaEvaluacion: String, completionHandler: @escaping (Result) -> ()) {
        
        let headers = ["grppId": "\(grppId)",
            "respuestaEvaluacion" : String(respuestaEvaluacion.filter { !" \n\t\r".contains($0) })]
        
        let url = URL(string: Constants.WEBSERVICE.evaluationResponse)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
            if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                if response.data != nil {
                    do {
                        let result = try JSONDecoder().decode(Result.self, from: response.data!)
                        if(result.status == "OK"){
                            result.isError = false
                            DispatchQueue.main.async {
                                completionHandler(result)
                            }
                        }else{
                            result.isError = true
                            DispatchQueue.main.async {
                                completionHandler(result)
                            }
                        }
                    }catch let error as NSError {
                        let result = Result()
                        result.isError = true
                        result.message = error.description
                        result.status = "Error"
                        DispatchQueue.main.async {
                            completionHandler(result)
                        }
                        print(error.description)
                    }
                }
            }
        }
    }
}
