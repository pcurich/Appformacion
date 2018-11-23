//
//  PollService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 4/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import RealmSwift
import UIKit

class PollService {
    
    static func getPolls(register: String, completionHandler: @escaping ([PollList]) -> ()) {
        let headers = ["registro":"\(register)"]//,"fechaformato":"201807240750"
        
        let url = URL(string: Constants.WEBSERVICE.polls)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
            if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                if response.data != nil {
                    do {
                        var polls = try JSONDecoder().decode(Polls.self, from: response.data!)
                        DispatchQueue.main.async {
                            if( polls.body == nil || polls.body?.count == 0){
                                completionHandler([PollList]())
                            }else{
                                for poll in 0...(polls.body?.count)! - 1 {
                                    for aspect in 0...polls.body![poll].aspects.count - 1{
                                        if(polls.body![poll].aspects[aspect].questions.count>0){
                                            for question in 0...polls.body![poll].aspects[aspect].questions.count - 1 {
                                                let t_question = polls.body![poll].aspects[aspect].questions[question]
                                                let t_aspect = polls.body![poll].aspects[aspect]
                                                polls.body![poll].aspects[aspect].questions[question].responseList =  PollService.getAnswer(questionType:  t_aspect.resposeType, questionId: t_question.questionId)
                                            }
                                        }
                                    }
                                }
                                completionHandler(polls.body!)
                            }
                            
                        }
                    }catch let error as NSError {
                        print(error.description)
                        DispatchQueue.main.async {
                            completionHandler([PollList]())
                        }
                    }
                }
            }
        }
    }
    
    static func save(grupoPersonaId: Int,scheduleId: Int, teacherId : Int ,respuestaEncuesta: String, completionHandler: @escaping (Result) -> ()) {
        let headers = ["grupoPersonaId": "\(grupoPersonaId)",
            "scheduleId": "\(scheduleId)",
            "expositorId": "\(teacherId)",
            "respuestaEncuesta" : String(respuestaEncuesta.filter { !"\n\t\r".contains($0) }) ]
        
        let url = URL(string: Constants.WEBSERVICE.pollResponse)
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
                    }
                }
            }
        }
    }
    
}


