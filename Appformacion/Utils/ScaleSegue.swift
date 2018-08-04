//
//  ScaleSegue.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 1/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
/*
class ScaleSegue : UIStoryboardSegue {
    override func perform() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in
            fromViewController.present(toViewController, animated: false, completion: nil)
            })
    }
}

class UnwindScaleSegue : UIStoryboardSegue {
    override func perform() {
        let toViewController = self.destination
        let fromViewController = self.source
   
     fromViewController.view.superview?.insertSubview(toViewController.view, at: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        }, completion: { success in
            fromViewController.dismiss(animated: false, completion: nil)
        })
    }
}
 */

class Helper{
    static func fitSizeLabel(size: Int, limit: Int) -> CGFloat {
        // ft -> px
        // 12 -> 34
        // 15 -> 43
        
        //las letras que caben por linea son 34
        if(size/limit > 0)
        {
            //el 20 es la altura que debe tener una linea
            if(size % limit > 0) {
                return CGFloat(20 * ((size/limit)+1))
            }else{
                return CGFloat(20 * size/limit)
            }
        }
        
        return CGFloat(limit)
    }
}
