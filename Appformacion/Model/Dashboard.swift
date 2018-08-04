//
//  Dashboard.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 20/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation

struct DashboardInfo: Codable {
    let message : String?
    let status  : String
    let body :  [String:[Dashboard]]?
}

struct Dashboard : Codable {
    let key : String?
    let detalle : String?
    let goto : String?
    let cantidad : Int
    
}
