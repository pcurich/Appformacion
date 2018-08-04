//
//  EnrollService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 2/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class EnrollService {
    
    static func enrollDevice(user : String, token : String, completionHandler: @escaping (String) -> ()) {
        
        let headers = ["mobileDeviceId": UIDevice.current.identifierForVendor!.uuidString,
                       "brand": "APPLE",
                       "model": UIDevice.current.model,
                       "operativeSystem": UIDevice.current.systemName,
                       "versionSystem": UIDevice.current.systemVersion,
                       "tokenPush": token,
                       "clientId": user]
        
        let url = URL(string: Constants.WEBSERVICE.enroll)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        var rpta : String = "ERROR"
        
        DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
            if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                if response.data != nil {
                    do {
                        let sideBarMenu = try JSONDecoder().decode(SideBarMenu.self, from: response.data!)
                        rpta = sideBarMenu.status as String
                        
                        if (rpta == "OK"){
                            
                            let oldMenu = RealmService.shared.realm.objects(MenuBBVA.self)
                            for old in oldMenu{
                                RealmService.shared.delete(old)
                            }
                            
                            for item in (sideBarMenu.body?.menu)! {
                                let menu = MenuBBVA(visible : item.visible, name : item.name, order : item.order, goto : item.goto)
                                RealmService.shared.create(menu)
                            }
                        }
                    }catch let error as NSError {
                        print(error.description)
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(rpta)
                    }
                }
            }
        }
    }
}

