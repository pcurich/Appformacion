//
//  UserService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 14/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

struct Login: Codable {
    let userName : String
    let password : String
}
class UserService  {
    
    static func processLogin(username : String, password : String, completionHandler: @escaping (String) -> ()) {
        
        let body = "username=\(username)&password=\(password)&login-form-type=pwd"
        let data = body.data(using: .utf8)!
        let url = URL(string: Constants.REST.login)!
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        
        
        DefaultAlamofireManager.sharedInstance.request(urlRequest).responseString { (response) in
            let cookies = HTTPCookieStorage.shared.cookies
            var result = false
            
            for cookie in cookies! {
                if cookie.name.uppercased() == "PD-S-SESSION-ID" || cookie.name.uppercased() == "PD-ID" {
                    result = true
                }
                debugPrint("name = " + cookie.name + " | " + "value = " + cookie.value )
            }
            if(result){
                DispatchQueue.main.async {
                    completionHandler("OK")
                }
            }else{
                DispatchQueue.main.async {
                    completionHandler("ERROR")
                }
            }
        }
    }
    
    static func processLogout(completionHandler: @escaping (String) -> ()) {
        
        let url = URL(string: Constants.REST.logout)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = "".data(using: .utf8)!
        
        DefaultAlamofireManager.sharedInstance.request(urlRequest).responseString { (response) in
            let cookies = HTTPCookieStorage.shared.cookies
            for cookie in cookies! {
                debugPrint("name = " + cookie.name + " | " + "value = " + cookie.value )
            }
            
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseString { (response) in
                
                if response.result.value != nil {
                    DispatchQueue.main.async {
                        completionHandler("OK")
                    }
                }else{
                    DispatchQueue.main.async {
                        completionHandler("ERROR")
                    }
                }
            }
        }
    }
    
    static func saveUserBBVA(user: String ){
        let userEntity : Results<UserBBVA> = RealmService.shared.realm.objects(UserBBVA.self)
        let newUser = UserBBVA(user: user)
        if(userEntity.count>0) {
            RealmService.shared.delete(userEntity.first!)
        }
        RealmService.shared.create(newUser)
    }
    
    static func saveUserGOOGLE(name:String, email:String, imagen: Data){
        let userEntity : Results<UserGOOGLE> = RealmService.shared.realm.objects(UserGOOGLE.self)
        let newUser = UserGOOGLE(name: name, email: email, imagen: imagen)
        if(userEntity.count>0) {
            RealmService.shared.delete(userEntity.first!)
        }
        RealmService.shared.create(newUser)
        
    }
    
    static func deleteUserGOOGLE(){
        let userEntity : Results<UserGOOGLE> = RealmService.shared.realm.objects(UserGOOGLE.self)
        if(userEntity.count>0) {
            RealmService.shared.delete(userEntity.first!)
        }
    }
    
    static func getUserBBVA() -> String {
        let realm = try! Realm()
        let users = realm.objects(UserBBVA.self)
        return users[0].userName
    }
    
    static func getUserGOOGLE() -> UserGOOGLE?    {
        let realm = try! Realm()
        let users = realm.objects(UserGOOGLE.self)
        if (users.count>0){
            return users[0]
        }
        else{
            return nil
        }
    }
}
