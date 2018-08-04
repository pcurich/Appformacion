//
//  AssistanceDetailTVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 3/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class AssistanceDetailTVC: UITableViewCell {

    @IBOutlet weak var lblHoraInicio: UILabel!
    @IBOutlet weak var lblHoraFin: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var imgCircle: UIImageView!
    @IBOutlet weak var imgType: UIImageView!
    
    let formatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Locale(identifier: "es_PE") //Calendar.current.locale
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var detalle: AssistanceDetailLine! {
        didSet {
            lblHoraInicio?.text = detalle.inicio
            lblHoraFin?.text = detalle.final
            lblDescripcion?.text = detalle.cursoNombre
            imgCircle?.setRounded()
            imgCircle?.backgroundColor = UIColor.red
            
            let date = Date()
            let currentTime = date.getTimeInt(date: date)
            let i_hh = (detalle.inicio!.split(separator: ":")[0] as NSString).integerValue
            let i_mm = (detalle.inicio!.split(separator: ":")[1] as NSString).integerValue
            let i_Time = i_hh*10000 + i_mm*100
            let f_hh = (detalle.final!.split(separator: ":")[0]  as NSString).integerValue
            let f_mm = (detalle.final!.split(separator: ":")[1]  as NSString).integerValue
            let f_Time = f_hh*10000 + f_mm*100
            
            if (i_Time<=currentTime && currentTime>=f_Time){
                imgCircle.backgroundColor = UIColor.green
            } 
             
        }
        
    }
    
}
