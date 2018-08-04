//
//  Color.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 7/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    class func BBVAMEDIUMBLUE() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "3_BBVAMEDIUMBLUE")!
        } else {
            return UIColor(displayP3Red: 42, green: 134, blue: 202, alpha: 1)
        }
    }
    class func BBVAWHITEMEDIUMBLUE() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "3_BBVAWHITEMEDIUMBLUE")!
        } else {
            return UIColor(displayP3Red: 73, green: 165, blue: 230, alpha: 1)
        }
    }
    class func BBVADARKMEDIUMBLUE() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "3_BBVADARKMEDIUMBLUE")!
        } else {
            return UIColor(displayP3Red: 20, green: 100, blue: 165, alpha: 1)
        }
    }
    class func BBVAAQUA() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "5_BBVAAQUA")!
        } else {
            return UIColor(displayP3Red: 45, green: 204, blue: 205, alpha: 1)
        }
    }
    class func BBVADARKAQUA() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "5_BBVADARKAQUA")!
        } else {
            return UIColor(displayP3Red: 2,  green: 132, blue: 132, alpha: 1)
        }
        
    }
    
    class func Aqua()-> UIColor {
        return UIColor(displayP3Red: 25, green: 255, blue: 179, alpha: 1)
    }
    
    class func CoreBlue() -> UIColor{
        return UIColor(displayP3Red: 0,  green: 39, blue: 143, alpha: 1)
    }
    
    class func DarkBlue() -> UIColor{
        return UIColor(displayP3Red: 0,  green: 97, blue: 242, alpha: 1)
    }
    
    class func MediumBlue() -> UIColor {
        return UIColor(displayP3Red: 61 , green: 206, blue: 242, alpha: 1)
    }
    
    class func LightBlue() -> UIColor{
        return UIColor(displayP3Red: 126, green: 230, blue: 230, alpha: 1)
    }

    class func Gray500	() -> UIColor{
        return UIColor(displayP3Red: 51, green:51, blue: 51, alpha: 1)
    }}
