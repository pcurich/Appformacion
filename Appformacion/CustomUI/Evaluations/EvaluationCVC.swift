        //
//  EvaluationCVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 12/07/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class EvaluationCVC: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgFondo: UIImageView!
    @IBOutlet weak var lblAlternativa: UILabel!
    @IBOutlet weak var radio: UIImageView!
    
    var uiColorBase : UIColor?
    var responseId : Int?
    var responseType: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiColorBase = imgFondo.backgroundColor
    }
    
    var alternative: EvaluationAnswer! {
        didSet {
            lblAlternativa.text = alternative.description
            responseId = alternative.responseId
        }
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected
            {
                imgFondo.backgroundColor = UIColor.BBVADARKAQUA()
                if("OPC_SIM"==responseType){
                    radio.image = #imageLiteral(resourceName: "check")
                    radio.setRounded()
                }else{
                    radio.image = #imageLiteral(resourceName: "mark")
                }
            }
            else
            {
                imgFondo.backgroundColor = uiColorBase
                if("OPC_SIM"==responseType){
                    radio.image = #imageLiteral(resourceName: "uncheck")
                    radio.setRounded()
                }else{
                    radio.image=#imageLiteral(resourceName: "unmark")
                }
            }
        }
    }
    
}
