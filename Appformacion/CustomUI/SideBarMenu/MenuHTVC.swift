//
//  MenuHTVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 2/10/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class MenuHTVC: UITableViewCell {
 
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var header: UILabel!
    
    var menuHeader : MenuHeader2!{
        didSet{
            header.text = menuHeader.title
            if(menuHeader.title == ""){
                imagen.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
