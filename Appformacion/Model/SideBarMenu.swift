//
//  File.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 4/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation

struct SideBarMenu: Codable {
    let message : String
    let status  : String
    let body :  SubSideBarMenu?
}

struct SubSideBarMenu: Codable {
    let version : String
    let menu : [MenuItem]
}

struct MenuItem: Codable {
    let visible : Bool
    let name : String
    let order : Int
    let goto : String
}
