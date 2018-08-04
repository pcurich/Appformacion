//
//  userGOOGLE.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 29/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import RealmSwift

class UserGOOGLE : Object {
    
    @objc dynamic var name : String?
    @objc dynamic var email :String?
    @objc dynamic var  imagen: Data?
    
    convenience  init(name : String, email : String, imagen: Data?) {
        self.init()
        self.name = name
        self.email = email
        self.imagen = imagen
        
    }}
