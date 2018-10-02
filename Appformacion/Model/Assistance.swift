//
//  Assistance.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 28/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation

struct CheckIn :Codable {
    let message : String?
    let status  : String
}

struct Assistance :Codable {
    let message : String?
    let status  : String
    let body: [String:[AssistanceLine]]?
}

struct AssistanceLine : Codable {
    let type    : String
    let grpdId  : Int
    let roomId  : Int
    let name    : String
    let address : String
    let code    : String?
    
    enum CodingKeys: String, CodingKey {
        case type    = "indicador" // CURS O PROG
        case grpdId  = "grpdId"
        case roomId  = "salaId"
        case name    = "nombre"
        case address = "direccion"
        case code    = "codigo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type    = try values.decode(String.self, forKey: .type)
        name    = try values.decode(String.self, forKey: .name)
        grpdId  = try values.decode(Int.self, forKey: .grpdId)
        roomId  = try values.decode(Int.self, forKey: .roomId)
        address = try values.decode(String.self, forKey: .address)
        code    = try values.decodeIfPresent(String.self, forKey: .code)
        
    }
}

struct AssistanceDetail : Codable {
    let message : String?
    let status  : String
    let body: [String:[AssistanceDetailLine]]?
}

struct AssistanceDetailLine : Codable {
    //let salaDisponibilidadId : Int?
    let type        : String
    let course      : String?
    let program     : String?
    let date        : String
    let startTime   : String
    let endTime     : String
    let schedulerId : Int
    let address     : String
    
    enum CodingKeys: String, CodingKey {
        case type        = "indicador" // CURS O PROG
        case course      = "cursoNombre"
        case program     = "programaNombre"
        case date        = "fecha"
        case startTime   = "inicio"
        case endTime     = "final"
        case schedulerId = "horarioid"
        case address     = "direccion"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type        = try values.decode(String.self, forKey: .type)
        course      = try values.decodeIfPresent(String.self, forKey: .course)
        program     = try values.decodeIfPresent(String.self, forKey: .program)
        date        = try values.decode(String.self, forKey: .date)
        startTime   = try values.decode(String.self, forKey: .startTime)
        endTime     = try values.decode(String.self, forKey: .endTime)
        schedulerId = try values.decode(Int.self, forKey: .schedulerId)
        address     = try values.decode(String.self, forKey: .address) 
    }
}

struct AssistanceProcess {
    let indicador : String?
    let evento : String?
    let fecha : String?
    let nombre : String?
    var assistenceDetailProcess : [AssistenceDetailProcess]? = []
}

struct AssistenceDetailProcess {
    let inicio : String?
    let final : String?
}
