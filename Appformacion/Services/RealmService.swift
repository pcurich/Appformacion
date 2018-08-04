//
//  RealmService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 4/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService{
    
    static let shared = RealmService()
    var realm = try! Realm()
    private init() {}
    
    func create<T: Object>(_ object : T){
        do {
            try realm.write {
                realm.add(object)
            }
        } catch  {
            post(error)
        }
    }
    
    func update<T: Object>(_ object: T,with dictionary: [String: Any?]){
        do {
            try realm.write {
                for (key,value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch  {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object : T){
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch  {
            post(error)
        }
    }
    
    func post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func  observeRealmErrors(in vc: UIViewController, completion: @escaping(Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) {
            (notification) in completion(notification.object as? Error)
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        let array = Array(self) as! [T]
        return array
    }
}

 


