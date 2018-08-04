//
//  EventCalendar.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 8/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation

struct EventCalendar : Decodable {
    let message : String
    let status  : String
    let body    : [String:[Calendario]]?
}

struct Calendario: Decodable {
    let fechaKey   : String
    let fechaValue : [FechaValue]
}

struct FechaValue: Decodable {
    let objetivo: String
    let fecha: String
    let tipo: String
    let grupoPersonaDetalleId : Int?
    let tema : String
    let sala: String
    let expositores: String
    let inicio: String
    let fin: String
    let nombre : String
    let grupoNombre : String
}

extension FechaValue : Equatable {
    static func ==(lhs: FechaValue, rhs: FechaValue) -> Bool {
        return lhs.fecha == rhs.fecha
    }
}
 
