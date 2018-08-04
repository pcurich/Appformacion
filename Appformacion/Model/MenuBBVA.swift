//
//  File.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 4/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import RealmSwift

class MenuBBVA : Object {
    @objc dynamic var  visible : Bool = false
    @objc dynamic var  name : String = ""
    @objc dynamic var  order : Int = 0
    @objc dynamic var  goto : String = ""
    
    convenience  init(visible : Bool, name : String, order : Int, goto : String) {
        self.init()
        self.visible = visible
        self.name = name
        self.order = order
        self.goto = goto
    }
    
}
