//
//  DetailCalendarTVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 14/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class DetailCalendarTVC: UITableViewCell {
    
    @IBOutlet weak var categoryLine: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var fechaValue: FechaValue! {
        didSet {
            titleLabel?.text = fechaValue.nombre
            noteLabel?.text = fechaValue.sala
            startTimeLabel?.text = fechaValue.inicio
            endTimeLabel?.text = fechaValue.fin
        }
    }}

