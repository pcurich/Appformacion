//
//  SettingsBBVA.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 5/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import RealmSwift
 
class AnswerBBVA: Object {
    
    @objc dynamic var EntityId = 0
    @objc dynamic var Name = ""
    @objc dynamic var Code = ""
    @objc dynamic var Value = ""
    
    convenience  init(Id:Int, Name : String , Code : String, Value: String) {
        self.init()
        self.EntityId = Id
        self.Name = Name
        self.Code = Code
        self.Value = Value
    }
}


