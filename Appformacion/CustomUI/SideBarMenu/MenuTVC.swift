//
//  MenuTVCell.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 5/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class MenuTVC: UITableViewCell {

    @IBOutlet weak var itemMenu: UILabel!
    @IBOutlet weak var icono: UIImageView!
    
    var item : MenuBBVA2! {
        didSet {
            itemMenu?.text = item.name
            icono.image = item.image.image 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) 
    }

}
