//
//  UserNameTextField.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 24/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class UserNameTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor(white: 231/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
