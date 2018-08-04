//
//  UserEntity.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 14/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import RealmSwift

class UserBBVA: Object {
   @objc dynamic var userName = ""
    
    convenience  init(user : String) {
        self.init()
        self.userName = user
    }
}
