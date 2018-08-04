//
//  Date.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 7/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
extension Date
{
    func from (year: Int, month: Int, day : Int) -> Date {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        let date = NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: c as DateComponents)
        
        return date!
    }
    
    func getCurrentYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
    
    func getCurrentMonth() -> Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.month, from: date)
    }
    
    func getMonthString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_PE")
        let calendar = Calendar.current
        let monthInt =  calendar.component(.month, from: date)
        return formatter.monthSymbols[monthInt-1].uppercased()
    }
    
    func getDayOfWeekString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_PE")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date).capitalized
    }
    
    func getCurrentDay() -> Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    func isThisMonth() -> Bool{
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "yyyyMMdd"
        
        let dateString = monthFormatter.string(from: self)
        let currentDateString = monthFormatter.string(from: Date())
        return dateString == currentDateString
    }
    
    func getTimeInt(date: Date)  -> Int{ 
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        return hour*10000 + minutes*100 + seconds
    }
}

class CustomHelper: NSObject {
    class func toDate(str : String, formate : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.date(from: str)!
    }
}


