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
    let type          : String
    let target        : String
    let name          : String
    let sessions      : String
    let urlDrive      : String?
    let pdfUrl        : String?
    let groupPersonId : Int
    let hashTag       : String?
  
    enum CodingKeys: String, CodingKey {
        case type          = "indicador" // CURS O PROG
        case target        = "objetivo"
        case name          = "nombre"    // Nombre del curso o programa
        case sessions      = "sesiones"
        case urlDrive      = "urlDrive"
        case pdfUrl        = "pdfurl"
        case groupPersonId = "grupoPersonaId"
        case hashTag       = "hashTag"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type          = try values.decode(String.self, forKey: .type)
        name          = try values.decode(String.self, forKey: .name)
        target        = try values.decode(String.self, forKey: .target)
        sessions      = try values.decode(String.self, forKey: .sessions)
        groupPersonId = try values.decode(Int.self, forKey: .groupPersonId)
        pdfUrl        = try values.decodeIfPresent(String.self, forKey: .pdfUrl)
        urlDrive      = try values.decodeIfPresent(String.self, forKey: .urlDrive)
        hashTag       = try values.decode(String.self, forKey: .hashTag)
    }
}

struct ActivityDetail :Codable {
    let message : String?
    let status  : String
    let body: [String:[ActividadDetalle]]?
}

struct ActividadDetalle : Codable {
 
    let date  : String
    let groupPersonId : Int
    let startTime  : String
    let endTime  : String
    let address  : String
    let room  : String
    let markAssistence : String
    
    enum CodingKeys: String, CodingKey {
        case date           = "fecha"
        case groupPersonId  = "grupoPersonaDetalleId"
        case startTime      = "horaInicio"
        case endTime        = "horaFinal"
        case address        = "direccion"
        case room           = "nombre"
        case markAssistence = "marcoAsistencia"
    }
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        date            = try values.decode(String.self, forKey: .date)
        groupPersonId   = try values.decode(Int.self, forKey: .groupPersonId)
        startTime       = try values.decode(String.self, forKey: .startTime)
        endTime         = try values.decode(String.self, forKey: .endTime)
        address         = try values.decode(String.self, forKey: .address)
        room            = try values.decode(String.self, forKey: .room)
        markAssistence  = try values.decode(String.self, forKey: .markAssistence)
    }
}
