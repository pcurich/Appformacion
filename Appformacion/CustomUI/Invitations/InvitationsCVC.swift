//
//  InvitationsCVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 21/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class InvitationsCVC: UICollectionViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var imgType: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var typeOfInvitation: UILabel!
    
    var invitation: CursosPendientesAceptacion! {
        didSet {
            let duracion : String = "Duracion: " + invitation.horas! + ":" + invitation.minutos!
            
            title.text = invitation.nombre!
            title.font = title.font.withSize(12)
            comment.text = duracion + " - Sesiones: " + "\(invitation.nroSessiones!)"
            typeOfInvitation.text = invitation.indicador == "CURS" ? "C" : "P"
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.addShadow()
        layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1.0)
    }

}
