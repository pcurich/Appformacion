//
//  Material.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 30/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
struct Material :Codable {
    let message : String?
    let status  : String
    let body: [String:[MaterialDetail]]?
}

struct MaterialDetail : Codable {
    let nombre : String?
    let indicador : String?
    let urlDrive : String?
}
