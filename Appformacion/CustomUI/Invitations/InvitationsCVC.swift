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
    
    var item : Int = 0 {
        didSet {
            if(item%2>0){
                imgType.backgroundColor = UIColor.BBVALIGHTBLUE()
            }
            else{
                imgType.backgroundColor = UIColor.BBVADARKAQUA() 
            }
        }
    }
    
    var invitation: CursosPendientesAceptacion! {
        didSet {
            let duracion : String = "Duracion: " + invitation.hours + ":" + invitation.minutes
            
            title.text = invitation.name
            title.font = title.font.withSize(12)
            comment.text = duracion + " - Sesiones: " + "\(invitation.nSessions)"
            comment.font = comment.font.withSize(12)
            typeOfInvitation.text = invitation.type == "CURS" ? "C" : "P"
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.addShadow()
        layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1.0)
    }

}
