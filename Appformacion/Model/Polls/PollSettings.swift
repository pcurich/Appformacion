//
//  Poll.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 4/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation

//CONFIGURACION DE ENCUENTAS
struct PollSettings: Codable {
    let message : String?
    let status  : String
    let body : [String:[PollAnswerSettings]]
} 

struct PollAnswerSettings :Codable {
    let clave : String
    let valor : String
    let id : Int
}



