//
//  PollHeaderTVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 26/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class PollAspectTVC: UITableViewCell {
    
    
    @IBOutlet weak var lblAspect: UILabel!
    @IBOutlet weak var lblTeacher: UILabel!
    @IBOutlet weak var imgCircle: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //imgCircle.addShadow()
        imgCircle.setRounded()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.BBVADARKAQUA()
        self.selectedBackgroundView = bgColorView
      
    }
    
    var aspect : PollAspect? {
        didSet{
            lblAspect.text = aspect?.description
            lblAspect.font = lblAspect.font.withSize(15)
            lblTeacher.text = aspect?.teacherName
            lblTeacher.font = lblTeacher.font.withSize(12)
        }
    }
  
}
