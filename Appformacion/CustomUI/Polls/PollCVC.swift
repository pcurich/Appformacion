//
//  PollCVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 9/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
class PollCVC : UICollectionViewCell  {
    
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgFondo: UIImageView!
    @IBOutlet weak var lblAlternativa: UILabel!
    
    @IBOutlet weak var txtSugerencia: UITextView!
 
    var questionId : Int?
    
    var alternative: PollAnswer! {
        didSet {
            lblAlternativa.text = alternative.value
            if((alternative.value?.count)!<=3){
                lblAlternativa.font = lblAlternativa.font.withSize(15)
            }else{
                lblAlternativa.font = lblAlternativa.font.withSize(10)
            }
            imgFondo.backgroundColor = UIColor.BBVAAQUA()
            questionId = alternative.questionId
        }
    }
     
    override var isSelected: Bool {
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                imgFondo.backgroundColor = UIColor.PoolSelected()
                //self.tickImageView.isHidden = false
            }
            else
            {
                self.transform = CGAffineTransform.identity
                imgFondo.backgroundColor = UIColor.PoolUnSelected()
                //self.tickImageView.isHidden = true
            }
        }
    }
}
