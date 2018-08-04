//
//  AssitenceDetailLineVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 3/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class AssistanceDetailLineVC: UIViewController {
    
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let current = Date()
        
        lblNumber.text = "\(current.getCurrentDay())"
        lblMonth.text = current.getMonthString(date: current)
        lblDay.text = current.getDayOfWeekString(date: current)
    }
    
    
    
}
