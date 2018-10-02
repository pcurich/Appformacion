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
    let type       : String
    let hours      : String
    let minutes    : String
    let name       : String
    let target     : String
    let scheduleId : String
    let groupId    : String
    let urlSilabus : String?
    let urlDrive   : String?
    let date       : String
    let nSessions  : String
    
    enum CodingKeys: String, CodingKey {
        case type          = "indicador" // CURS O PROG
        case hours         = "horas"
        case minutes       = "minutos"
        case name          = "nombre"    // Nombre del curso o programa
        case target        = "objetivo"
        case groupId       = "grupoId"
        case scheduleId    = "horarioId"
        case urlSilabus    = "urlSilabus"
        case urlDrive      = "urlDrive"
        case date          = "fecha"
        case nSessions     = "nroSessiones"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type          = try values.decode(String.self, forKey: .type)
        hours         = try values.decode(String.self, forKey: .hours)
        minutes       = try values.decode(String.self, forKey: .minutes)
        name          = try values.decode(String.self, forKey: .name)
        target        = try values.decode(String.self, forKey: .target)
        scheduleId    = try values.decode(String.self, forKey: .scheduleId)
        groupId       = try values.decode(String.self, forKey: .groupId)
        urlSilabus    = try values.decodeIfPresent(String.self, forKey: .urlSilabus)
        urlDrive      = try values.decodeIfPresent(String.self, forKey: .urlDrive)
        date          = try values.decode(String.self, forKey: .date)
        nSessions     = try values.decode(String.self, forKey: .nSessions)
    }
    
}

struct InvitationDetails :Codable {
    let message : String?
    let status  : String
    let body: [String:[CursoDetalle]]?
}

struct CursoDetalle : Codable {
    let date       : String
    let startTime  : String
    let endTime    : String  
    let room       : String
    let address    : String
    let latitude   : String
    let longitude  : String
    let dateFormat : String
    let url        : String
    
    enum CodingKeys: String, CodingKey {
        case date       = "fecha"
        case startTime  = "horaInicio"
        case endTime    = "horaFinal"
        case room       = "sala"
        case address    = "direccion"
        case latitude   = "latitud"
        case longitude  = "longitud"
        case dateFormat = "fechaInicioFormato"
        case url        = "urlUbicacion"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date       = try values.decode(String.self, forKey: .date)
        startTime  = try values.decode(String.self, forKey: .startTime)
        endTime    = try values.decode(String.self, forKey: .endTime)
        room       = try values.decode(String.self, forKey: .room)
        address    = try values.decode(String.self, forKey: .address)
        latitude   = try values.decode(String.self, forKey: .latitude)
        longitude  = try values.decode(String.self, forKey: .longitude)
        dateFormat = try values.decode(String.self, forKey: .dateFormat)
        url        = try values.decode(String.self, forKey: .url)
    }
}

struct RespuestaTipo :Codable {
    let message : String?
    let status  : String
    let body: [String:[InvitacionTipo]]?
}

struct InvitacionTipo : Codable {
    let flag : Int
    let label : String
    let code : String
    
    enum CodingKeys: String, CodingKey {
        case flag  = "flag"
        case label = "label"
        case code  = "tipoRespuesta"
    }
    
    init(flag: Int, label:String, code: String) {
        self.flag = flag
        self.code = code
        self.label = label
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flag  = try values.decode(Int.self, forKey: .flag)
        label = try values.decode(String.self, forKey: .label)
        code  = try values.decode(String.self, forKey: .code)
    }
}

struct Respuesta : Codable {
    let message : String?
    let status  : String
}
