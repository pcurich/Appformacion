//
//  Activity.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 26/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation

struct Activity :Codable {
    let message : String?
    let status  : String
    let body: [String:[ActividadesProgramadas]]?
}

struct ActividadesProgramadas: Codable {
    let sesiones : String?
    let urlDrive : String?
    let grupoPersonaId : Int?
    let nombre : String?
    let objetivo : String?
    let pdfurl : String?
    let hashTag : String?
    let indicador : String?
}

struct ActivityDetail :Codable {
    let message : String?
    let status  : String
    let body: [String:[ActividadDetalle]]?
}

struct ActividadDetalle : Codable {
    let fecha  : String?
    let horaInicio  : String?
    let horaFinal  : String?
    let accion  : String?
    let urlubicacion  : String?
    let latitud   : String?
    let longitud  : String?
    let grupoPersonaDetalleId : Int
    let direccion  : String?
    let nombre  : String?
    let marcoAsistencia  : String?
}
