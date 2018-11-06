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
        
        
        func hexStringToUIColor (hex:String) -> UIColor {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            
            if ((cString.count) != 6) {
                return UIColor.gray
            }
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
    
    class func BBVALIGHTBLUE() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "4_BBVALIGHTBLUE")!
        } else {
            return UIColor(displayP3Red: 91.0/255.0, green: 190.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    class func BBVAMEDIUMBLUE() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "3_BBVAMEDIUMBLUE")!
        } else {
            return UIColor(displayP3Red: 42.0/255.0, green: 134.0/255.0, blue: 202.0/255.0, alpha: 1)
        }
    }
    class func BBVAWHITEMEDIUMBLUE() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "3_BBVAWHITEMEDIUMBLUE")!
        } else {
            return UIColor(displayP3Red: 73.0/255.0, green: 165.0/255.0, blue: 230.0/255.0, alpha: 1)
        }
    }
    class func BBVADARKMEDIUMBLUE() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "3_BBVADARKMEDIUMBLUE")!
        } else {
            return UIColor(displayP3Red: 20.0/255.0, green: 100.0/255.0, blue: 165.0/255.0, alpha: 1)
        }
    }
    class func BBVAAQUA() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "5_BBVAAQUA")!
        } else {
            return UIColor(displayP3Red: 45.0/255.0, green: 204.0/255.0, blue: 205.0/255.0, alpha: 1)
        }
    }
    class func BBVADARKAQUA() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "5_BBVADARKAQUA")!
        } else {
            return UIColor(displayP3Red: 2.0/255.0,  green: 132.0/255.0, blue: 132.0/255.0, alpha: 1)
        }
        
    }
    
    class func Aqua()-> UIColor {
        return UIColor(displayP3Red: 25.0/255.0, green: 255.0/255.0, blue: 179.0/255.0, alpha: 1)
    }
    
    class func PoolUnSelected()-> UIColor {
        return UIColor(colorWithHexValue: 0x229FD7)
    }
    
    class func PoolSelected()-> UIColor {
        return UIColor(colorWithHexValue: 0x30CEC3 )
    }
    
    class func CoreBlue() -> UIColor{
        return UIColor(displayP3Red: 0.0/255.0,  green: 39.0/255.0, blue: 143.0/255.0, alpha: 1)
    }
    
    class func DarkBlue() -> UIColor{
        return UIColor(displayP3Red: 0.0/255.0,  green: 97.0/255.0, blue: 242.0/255.0, alpha: 1)
    }
    
    class func MediumBlue() -> UIColor {
        return UIColor(displayP3Red: 61.0/255.0 , green: 206.0/255.0, blue: 242.0/255.0, alpha: 1)
    }
    
    class func LightBlue() -> UIColor{
        return UIColor(displayP3Red: 126.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
    }

    class func Gray500	() -> UIColor{
        return UIColor(displayP3Red: 51.0/255.0, green:51.0/255.0, blue: 51.0/255.0, alpha: 1)
    }}
