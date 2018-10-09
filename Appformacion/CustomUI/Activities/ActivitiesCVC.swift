//
//  ActivitiesCVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 26/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit


class ActivitiesCVC: UICollectionViewCell {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var typeOfInvitation: UILabel!
    
    @IBOutlet weak var type: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var item : Int = 0 {
        didSet {
            if(item%2>0){
                type.backgroundColor = UIColor.BBVALIGHTBLUE()
            }
            else{
                type.backgroundColor = UIColor.BBVADARKAQUA()
                
            }
        }
    }
    
    var actividad: ActividadesProgramadas! {
        didSet {
            
            let num = actividad.sessions.split(separator: "/")[0]
            let den = actividad.sessions.split(separator: "/")[1]
            
            let result = ((num as NSString).doubleValue * 100 / (den as NSString).doubleValue)
            
            lblProgress.text =  "\(result.truncate(places: 2))" + " %"
            lblTitle.text = actividad.name
            
            lblTitle.font = lblTitle.font.withSize(12)
            lblProgress.font = lblProgress.font.withSize(10)
            
            
            typeOfInvitation.text = actividad.type == "CURS" ? "C" : "P"
            progressBar.progress = ((num as NSString).floatValue / (den as NSString).floatValue)
            
            if progressBar.transform.d<2 {
                progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
            }
        }
        
    }
}
