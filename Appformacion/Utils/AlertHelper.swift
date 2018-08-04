//
//  AlertHelper.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 14/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    
    class func notificationAlert(title: String, message:String, viewController : UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let successAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
        }
        
        alertController.addAction(successAction)
        viewController.present(alertController, animated: true, completion:nil)
    }
}
