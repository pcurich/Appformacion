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
            let fecha = formatter.date(from:detalle.fecha!)
            let ahora = Date()
            var color = UIColor.green
            
            if(fecha == ahora){
                color = UIColor.yellow
            }
            if((ahora > fecha!) && (detalle.marcoAsistencia=="NO")){
                color = UIColor.red
            }
            
            lblSubTitle?.text = detalle.nombre
            lblTitle?.text = detalle.fecha
            lblEnd?.text = detalle.horaFinal
            lblStart?.text = detalle.horaInicio
            lblSubtitle2?.text = detalle.direccion
            imgCircle?.backgroundColor = color
            imgCircle?.layer.cornerRadius = (imgCircle?.frame.size.width)! / 2
            imgCircle?.clipsToBounds = true
        }
    }
    
}
