//
//  ButtonCVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 20/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class ButtonCVC: UICollectionViewCell {

  
    @IBOutlet var topic: UILabel!
    //@IBOutlet var circle: UIImageView!
    @IBOutlet var number: UILabel!
    @IBOutlet weak var imgCircle: UIImageView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCircle.setRounded()
    }
    
    var dashboard: Dashboard! {
        didSet {
            number.text = "\(dashboard.cantidad)"
            topic.text = dashboard.detalle
        }
    }

}
