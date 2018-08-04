//
//  AssistanceCVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 28/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class AssistanceCVC: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var typeOfInvitation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var asistencia: AssistanceLine! {
        didSet {
            
            lblTitle.text = asistencia.nombre!
            lblTitle.font = lblTitle.font.withSize(15)
            
            lblSubTitle.text = asistencia.direccion
            lblTitle.font = lblTitle.font.withSize(12)
    
            typeOfInvitation.text = asistencia.indicador == "CURS" ? "C" : "P"
           
        }
        
    }
    
}
