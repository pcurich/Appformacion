//
//  Invitation.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 21/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
struct Invitation :Codable {
    let message : String?
    let status  : String
    let body: [String:[CursosPendientesAceptacion]]?
}

struct CursosPendientesAceptacion : Codable {
    let tipoEvento : String?
    let indicador : String?
    let grupoId : String?
    let horas : String?
    let minutos : String?
    let nombre : String?
    let objetivo : String?
    let tema : String?
    let codigo : String?
    let contenido : String?
    let horarioId : String?
    let urlSilabus : String?
    let urlDrive : String?
    let fecha : String?
    let nroSessiones : String?
}

struct InvitationDetails :Codable {
    let message : String?
    let status  : String
    let body: [String:[CursoDetalle]]?
}

struct CursoDetalle : Codable {
    let fecha  : String?
    let horaInicio  : String?
    let horaFinal  : String?
    let sala  : String?
    let direccion  : String?
    let latitud  : String?
    let longitud  : String?
    let urlUbicacion  : String?
    let fechaInicioFormato  : String?
}

struct RespuestaTipo :Codable {
    let message : String?
    let status  : String
    let body: [String:[InvitacionTipo]]?
}

struct InvitacionTipo : Codable {
    let flag : Int?
    let label : String?
    let tipoRespuesta : String?
}

struct Respuesta : Codable {
    let message : String?
    let status  : String
}
