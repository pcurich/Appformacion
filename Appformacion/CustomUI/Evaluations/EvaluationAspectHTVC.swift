//
//  EvaluationAspectHTVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 12/07/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class EvaluationAspectHTVC: UITableViewCell {

    @IBOutlet weak var typeOfInvitation: UILabel!
    @IBOutlet weak var lblCourseOrProgram: UILabel!
    @IBOutlet weak var imgSquare: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgSquare.addShadow()
    }
    
    var item : Int = 0 {
        didSet {
            if(item%2>0){
                imgSquare.backgroundColor = UIColor.BBVALIGHTBLUE()
            }
            else{
                imgSquare.backgroundColor = UIColor.BBVADARKAQUA()
            }
        }
    }
    
    var evaluation : EvaluationList! {
        didSet {
            
            lblCourseOrProgram.text = evaluation.name
            lblCourseOrProgram.font = lblCourseOrProgram.font.withSize(15)
            typeOfInvitation.text = evaluation.type == "CURS" ? "C" : "P"
        }
    }
    
}
