//
//  DetailActivityTVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 27/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class DetailActivityTVC: UITableViewCell {

    @IBOutlet weak var imgCircle: UIImageView!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    let formatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Locale(identifier: "es_PE") //Calendar.current.locale
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    @IBOutlet weak var lblSubtitle2: UILabel!
    var detalle: ActividadDetalle! {
        didSet {
            let fecha = formatter.date(from:detalle.date)
            let ahora = Date()
            var color = UIColor.green
            
            if(fecha == ahora){
                color = UIColor.yellow
            }
            if((ahora > fecha!) && (detalle.markAssistence=="NO")){
                color = UIColor.red
            }
            
            lblSubTitle?.text = detalle.room
            lblTitle?.text = detalle.date
            lblEnd?.text = detalle.startTime
            lblStart?.text = detalle.endTime
            lblSubtitle2?.text = detalle.address
            imgCircle?.backgroundColor = color
            imgCircle?.layer.cornerRadius = (imgCircle?.frame.size.width)! / 2
            imgCircle?.clipsToBounds = true
        }
    }
    
}
