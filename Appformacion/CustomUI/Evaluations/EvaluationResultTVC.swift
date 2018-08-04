//
//  EvaluarionResultTVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 17/07/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class EvaluationResultTVC: UITableViewCell {

    @IBOutlet weak var imgCircle  : UIImageView!
    @IBOutlet weak var alternativa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCircle.setRounded()
    }
    
    var type: String! {
        didSet {
            if(type == "RPTA_COR"){
                imgCircle.backgroundColor = UIColor.green
            }else {
                imgCircle.backgroundColor = UIColor.red
            }
        }
    }
 
    
}
