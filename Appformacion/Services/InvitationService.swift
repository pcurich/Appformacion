//
//  InvitationService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 23/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class InvitationService {
    
    static func getInvitations(register: String, completionHandler: @escaping ([CursosPendientesAceptacion]) -> ()) {
        let headers = ["registro":"\(register)"]
        
        let url = URL(string: Constants.WEBSERVICE.invitations)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let invitations = try JSONDecoder().decode(Invitation.self, from: response.data!)
                            completionHandler((invitations.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                }
            }
        }
    }
    
    static func getDetails(horarioId: String, completionHandler: @escaping ([CursoDetalle]) -> ()) {
        let headers = ["horarioId":"\(horarioId)"]
        
        let url = URL(string: Constants.WEBSERVICE.invitationDetails)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let details = try JSONDecoder().decode(InvitationDetails.self, from: response.data!)
                            completionHandler((details.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                }
            }
        }
    }
    
    static func getResponseList(completionHandler: @escaping ([InvitacionTipo]) -> ()) {
        
        let url = URL(string: Constants.WEBSERVICE.invitationsResponseList)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        DispatchQueue.main.async {
            
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let types = try JSONDecoder().decode(RespuestaTipo.self, from: response.data!)
                            completionHandler((types.body?.values.first)!)
                        }catch let error as NSError {
                            print(error.description)
                            completionHandler([InvitacionTipo]()) 
                        }
                    }
                }
            }
        }
    }
    
    static func responseInvitation(grupoId : String, tipoRespuesta: String, flag : Int,  completionHandler: @escaping (Bool) -> ()) {
        
        let user = UserService.getUserBBVA()
        let headers = ["grupoid" : "\(grupoId)", "registro" : "\(user)", "tipoRespuesta":"\(tipoRespuesta)","flag":"\(flag)"]
        
        let url = URL(string: Constants.WEBSERVICE.responderInvitacion)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let respuesta = try JSONDecoder().decode(Respuesta.self, from: response.data!)
                            completionHandler(respuesta.status == "OK")
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                }
            }
        }
    }
}
