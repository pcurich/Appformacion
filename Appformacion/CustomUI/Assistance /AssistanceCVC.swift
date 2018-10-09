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
    @IBOutlet weak var imgType: UIImageView!
    
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var typeOfInvitation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
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
    
    var asistencia: AssistanceLine! {
        didSet {
            
            lblTitle.text = asistencia.name
            lblTitle.font = lblTitle.font.withSize(15)
            
            lblSubTitle.text = asistencia.address
            lblTitle.font = lblTitle.font.withSize(12)
    
            typeOfInvitation.text = asistencia.type == "CURS" ? "C" : "P"
           
        }
        
    }
    
}
