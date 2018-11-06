//
//  AppDelegate.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 13/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import GoogleSignIn
import RealmSwift

import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var currentViewController : UIViewController?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Sobrecarga del Punto de inicio de la aplicación después de la personalización.
        
        // Configracion general del teclado
        // https://www.youtube.com/watch?v=b6njX3Ui8qU
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        application.statusBarStyle = .lightContent
        
        /*
         Migraciones de Realm
         https://realm.io/docs/swift/latest/#migrations
         */
        
        self.initFirebase(application)
        return true
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        ConnectToFCM()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {}
    
    func application(_ app: UIApplication, open url: URL,  sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    //MARK: Firebase Configure
    
    func initFirebase(_ application: UIApplication){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
            if err != nil {
                //Something bad happend
            } else {
                UNUserNotificationCenter.current().delegate = self
                Messaging.messaging().delegate = self
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        FirebaseApp.configure()
    }
    
    func ConnectToFCM() {
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        if let token = InstanceID.instanceID().token() {
            print("DCS: " + token)
        }
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        ConnectToFCM()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        UIApplication.shared.applicationIconBadgeNumber += 1
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.DouglasDevlops.BadgeWasUpdated"), object: nil)
    }
    
    // MARK: WEBSEAL SESSION
    
    func sessionValid(response : DataResponse<Any>) -> Bool{
        
        //just for QuGo developers
        if !Constants.REST.useLogin {
            return true
        }
        
        guard let headers = response.response?.allHeaderFields as? [String: String] else {
            self.closeSession()
            return false
        }
        
        if(headers["x-mule_session"]==nil && headers["X-MULE_SESSION"]==nil){
            self.closeSession()
            return false
        }
        
        return true
    }
    
    func closeSession(){
        
        if(!(self.currentViewController is LoginVC)){
            
            if(currentViewController is BaseVC?){
                (currentViewController as! BaseVC?)?.close()
            }
        }
    }
}

