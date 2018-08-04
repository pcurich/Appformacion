//
//  Local.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 23/07/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import UserNotifications
class NotificationLocalVC: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func lanzar(_ sender: UIButton) {
        
        var dateComponent = DateComponents()
        dateComponent.hour = 10
        dateComponent.minute = 30
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let action  = UNNotificationAction(identifier: "action", title: "CAMBIAR COLOR", options: [])
        let borrar  = UNNotificationAction(identifier: "borrar", title: "BORRAR", options: [])
        let categoriaCursoLibre = UNNotificationCategory(identifier: "CURSOLIBRE", actions: [action, borrar], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([categoriaCursoLibre])
        
        let contenido = UNMutableNotificationContent()
        contenido.title = "Recordatorio"
        contenido.subtitle = "Curso o Programa"
        contenido.body = "Recordatorio para la asistencia al curso o programa "
        contenido.sound = UNNotificationSound.default()
        contenido.categoryIdentifier = "CURSOLIBRE"
        
        if let path = Bundle.main.path(forResource: "imagen", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do{
                let imagen = try UNNotificationAttachment(identifier: "imagen", url: url, options: nil)
                contenido.attachments = [imagen]
            }catch{
                print("no cargo la imagen")
            }
        }
        
        
        let request = UNNotificationRequest(identifier: "notificacion1", content: contenido, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("fallo la notificacion", error)
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "action"{
            self.view.backgroundColor = UIColor.blue
        } else if response.actionIdentifier == "borrar" {
            print("se borro la notificacion")
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["notificacion1"])
        }
    }
}
