//
//  EvaluationListCVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 18/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class EvaluationAspectTVC: UITableViewCell {

    @IBOutlet weak var lblAspect: UILabel! 
    @IBOutlet weak var imgCircle: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //imgCircle.addShadow()
        imgCircle.setRounded()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.BBVADARKAQUA()
        self.selectedBackgroundView = bgColorView
        
    }
    
    var aspect : EvaluationAspect? {
        didSet{
            lblAspect.text = aspect?.description
            lblAspect.font = lblAspect.font.withSize(15)
        }
    }
}
