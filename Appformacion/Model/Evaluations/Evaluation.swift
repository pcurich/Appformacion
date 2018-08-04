//
//  PollResponse.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 28/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

//RESPUESTA
struct EvaluationResponse : Codable {
    var preguntaId : Int
    var codPregunta : String
    var respuestas : [Int]
    var esCorrecto : Bool
}

//ENCUESTAS X ASPECTO
struct Evaluations : Codable {
    let message : String?
    let status  : String?
    var body    : [EvaluationList]? 
}

struct EvaluationList : Codable { 
    let type          : String?
    let name          : String?
    var aspects       : [EvaluationAspect] = []
    
    enum CodingKeys: String, CodingKey {
        case type          = "indicador" // CURS O PROG
        case name          = "nombre"    // Nombre del curso o programa
        case aspects       = "evaluacionesList"  // LISTA
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type          = try values.decodeIfPresent(String.self, forKey: .type)
        name          = try values.decodeIfPresent(String.self, forKey: .name)
        aspects       = try values.decode([EvaluationAspect].self, forKey: .aspects)
    }
    
}

struct EvaluationAspect : Codable {
    var percent       : Double = 0.0
    var description   : String?
    var aspectId      : Int = 0
    var questions     : [EvaluationQuestion] = []
    
    enum CodingKeys: String, CodingKey {
        case percent       = "porcentaje"
        case description   = "evaluacionNombre"
        case questions     = "preguntas"
        case aspectId      = "grppId"
    }
    
    init(from decoder: Decoder) throws {
        let values    = try decoder.container(keyedBy: CodingKeys.self)
        description   = try values.decodeIfPresent(String.self, forKey: .description)
        questions     = try values.decode([EvaluationQuestion].self,forKey: .questions)
        percent       = try values.decode(Double.self,forKey: .percent)
        aspectId      = try values.decode(Int.self,forKey: .aspectId)
    }
}

struct EvaluationQuestion : Codable {
    var questionId   : Int = 0
    var order        : Int = 0
    var question     : String = ""
    var responseType : String = "" 
    var responseList : [EvaluationAnswer] = []
    
    enum CodingKeys: String, CodingKey {
        case questionId       = "preguntaId"
        case order            = "nroOrden"
        case question         = "pregunta"
        case responseType     = "codPregunta" // OPC_SIM OPC_MUL
        case responseList     = "alternativas"
    }
    
    init(from decoder: Decoder) throws {
        let values   = try decoder.container(keyedBy: CodingKeys.self)
        questionId   = try values.decode(Int.self, forKey: .questionId)
        order        = try values.decode(Int.self, forKey: .order)
        question     = try values.decode(String.self, forKey: .question)
        responseType = try values.decode(String.self, forKey: .responseType)
        responseList = try values.decode([EvaluationAnswer].self, forKey: .responseList)
    }
    
    init(questionId: Int, question: String,responseList: [EvaluationAnswer]){
        self.questionId = questionId
        self.question = question
        self.responseList = responseList
    }
}

struct EvaluationAnswer  : Codable {
    var responseId   : Int = 0
    var order        : String = ""
    var description  : String = ""
    var responseType : String = "" //RPTA_COR - RPTA_INC
    var isSelected   : Bool = false
    
    enum CodingKeys: String, CodingKey {
        case responseId    = "alternativaId"
        case order         = "letra"
        case description   = "descripcion"
        case responseType  = "codRespuesta"
    }
    
    init(from decoder: Decoder) throws {
        let values   = try decoder.container(keyedBy: CodingKeys.self)
        responseId   = try values.decode(Int.self, forKey: .responseId)
        order        = try values.decode(String.self, forKey: .order)
        description  = try values.decode(String.self, forKey: .description)
        responseType = try values.decode(String.self, forKey: .responseType)
    }
    
    init(description: String, responseType : String){
        self.description = description
        self.responseType = responseType
    }
}
