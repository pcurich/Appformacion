//
//  MaterialCVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 30/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class MaterialCVC: UICollectionViewCell {
    
    @IBOutlet weak var typeOfInvitation: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgSquare: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        imgSquare.addShadow()
        
    }
    
    var material: MaterialDetail! {
        didSet {
            lblTitle.text = material.name
            lblTitle.font = lblTitle.font.withSize(12)
            typeOfInvitation.text = material.type == "CURS" ? "C" : "P"
        }
    }
  
    
}
