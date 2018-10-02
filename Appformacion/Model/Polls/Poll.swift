//
//  PollResponse.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 28/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

//RESPUESTA
struct PollResponse : Codable {
    var preguntaId : Int
    var rtaId : Int
    var rtadDescription : String
}

//ENCUESTAS X ASPECTO
struct Polls :Codable {
    let message : String?
    let status  : String?
    var body    : [PollList]?
}

struct PollList : Codable {
    let name          : String
    let type          : String
    let groupPersonId : Int
    var aspects       : [PollAspect] = []
    
    enum CodingKeys: String, CodingKey {
        case name          = "nombre"    // Nombre del curso o programa
        case type          = "indicador" // CURS O PROG
        case aspects       = "encuestas"  // LISTA
        case groupPersonId = "grupoPersonaId"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name          = try values.decode(String.self, forKey: .name)
        type          = try values.decode(String.self, forKey: .type)
        aspects       = try values.decode([PollAspect].self, forKey: .aspects)
        groupPersonId = try values.decode(Int.self, forKey: .groupPersonId)
    }
}

struct PollAspect : Codable {
    var description   : String
    var teacherId     : Int?
    var teacherName   : String?
    var aspectId      : Int
    var resposeType   : String
    var resposeTypeId : Int
    var scheduleId    : Int
    var questions     : [PollQuestion] = []
    
    enum CodingKeys: String, CodingKey {
        case description   = "aspectoDetalle"
        case teacherId     = "expositorId"
        case aspectId      = "encuestaId"
        case teacherName   = "expositorNombre"
        case resposeType   = "respuestaCode"
        case resposeTypeId = "respuestaId"
        case scheduleId    = "scheduleId"
        case questions     = "preguntas"
    }
    
    init(from decoder: Decoder) throws {
        let values    = try decoder.container(keyedBy: CodingKeys.self)
        description   = try values.decode(String.self, forKey: .description)
        teacherId     = try values.decodeIfPresent(Int.self, forKey: .teacherId)
        teacherName   = try values.decodeIfPresent(String.self, forKey: .teacherName)
        resposeType   = try values.decode (String.self, forKey: .resposeType)
        questions     = try values.decode ([PollQuestion].self,forKey: .questions)
        aspectId      = try values.decode (Int.self, forKey: .aspectId)
        resposeTypeId = try values.decode (Int.self, forKey: .resposeTypeId)
        scheduleId    = try values.decode (Int.self, forKey: .scheduleId)
    }
}

struct PollQuestion : Codable {
    let questionId   : Int
    let note         : String?
    let question     : String
    
    var number : Int?
    var responseList : [PollAnswer] = []
    
    enum CodingKeys: String, CodingKey {
        case questionId   = "id"
        case note         = "nota"
        case question     = "pregunta"
    }
    
    init(from decoder: Decoder) throws {
        let values   = try decoder.container(keyedBy: CodingKeys.self)
        questionId   = try values.decode(Int.self, forKey: .questionId)
        note         = try values.decodeIfPresent(String.self, forKey: .note)
        question     = try values.decode(String.self, forKey: .question)
    }
}

struct PollAnswer  : Codable {
    var questionId : Int = 0
    var responseId : Int = 0
    let name       : String?
    let code       : String?
    let value      : String?
    var isSelected : Bool = false
    
    init(questionId: Int, responseId: Int, name: String, code: String, value: String ){
        self.questionId = questionId
        self.responseId = responseId
        self.name = name
        self.code = code
        self.value = value
    }
    
}
