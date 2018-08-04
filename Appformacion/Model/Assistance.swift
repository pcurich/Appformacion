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
    let grpdId : Int?
    let salaId : Int?
    let nombre : String?
    let direccion : String?
    let indicador : String?
    let latitud : String?
    let longitud : String?
    let urlUbicacion : String?
    let codigo : String?
}

struct AssistanceDetail : Codable {
    let message : String?
    let status  : String
    let body: [String:[AssistanceDetailLine]]?
}

struct AssistanceDetailLine : Codable {
    let salaDisponibilidadId : Int?
    let programaNombre : String?
    let cursoNombre : String?
    let indicador : String?
    let fecha : String?
    let inicio : String?
    let final : String?
    let horarioid : Int?
    let direccion : String?
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
