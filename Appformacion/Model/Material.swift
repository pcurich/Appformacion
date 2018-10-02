//
//  Material.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 30/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

struct Material :Codable {
    let message : String?
    let status  : String
    let body: [String:[MaterialDetail]]?
}

struct MaterialDetail : Codable {
    let name : String
    let type : String
    let urlDrive : String?
    
    enum CodingKeys: String, CodingKey {
        case name     = "nombre"
        case type     = "indicador"
        case urlDrive = "urlDrive"
    }
    
    init(from decoder: Decoder) throws {
        let values   = try decoder.container(keyedBy: CodingKeys.self)
        name         = try values.decode(String.self, forKey: .name)
        type         = try values.decode(String.self, forKey: .type)
        urlDrive     = try values.decodeIfPresent(String.self, forKey: .urlDrive)
    }
}
