//
//  CalendarService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 8/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class CalendarService {
    var date : String?
    var schedules : [EventCalendar]?
    
    static func getEventCalendarOnBackground(year: String, month : String, register: String, completionHandler: @escaping ([String : [FechaValue]]) -> ()){
        
        let headers = ["registro":register,
                       "ano": year,
                       "mes": month]
        
        
        let url = URL(string: Constants.WEBSERVICE.calendar)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        
        var eventCal = [String:[FechaValue]]()
        
        DispatchQueue.main.async {
            
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let eventCalendar = try JSONDecoder().decode(EventCalendar.self, from: response.data!)
                            for calendar in eventCalendar.body! {
                                for date in calendar.value {
                                    for value in date.fechaValue {
                                        let fechaKey = String(date.fechaKey)
                                        if (eventCal[fechaKey] == nil) {
                                            eventCal[fechaKey]  = [FechaValue]()
                                        }
                                        eventCal[fechaKey]?.append(value)
                                    }
                                }
                            }
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                    completionHandler(eventCal)
                }
            }
        }
    }
}
