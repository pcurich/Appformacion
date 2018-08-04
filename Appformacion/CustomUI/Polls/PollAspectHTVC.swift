//
//  PollHeaderTVC2.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 1/07/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class PollAspectHTVC: UITableViewCell {

    @IBOutlet weak var typeOfInvitation: UILabel!
    @IBOutlet weak var lblCourseOrProgram: UILabel!
    @IBOutlet weak var imgSquare: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgSquare.addShadow()
    }
    
    var poll : PollList! {
        didSet {
            
            lblCourseOrProgram.text = poll.name
            lblCourseOrProgram.font = lblCourseOrProgram.font.withSize(15)
            typeOfInvitation.text = poll.type == "CURS" ? "C" : "P"
        }
    }
  
}
