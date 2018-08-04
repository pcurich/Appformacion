//
//  ViewController.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 13/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import RealmSwift

class LoginVC: BaseVC {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPassword: PasswordTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.BBVAMEDIUMBLUE()
        //self.btnLogin.backgroundColor = UIColor.BBVADARKAQUA()
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard txtUser.text != ""  else {
            AlertHelper.notificationAlert(title: "Error", message: "Ingrese su registro", viewController: self)
            return
        }
        guard txtPassword.text != ""  else {
            AlertHelper.notificationAlert(title: "Error", message: "Ingrese su contraseña", viewController: self)
            return
        }
        let user : String? =  txtUser.text
        let password : String? = txtPassword.text
        
        UserDefaults.standard.set(user, forKey: "registro")
        
        if Constants.REST.useLogin {
            
            UserService.processLogin(username: user!, password: password!, completionHandler:  {
                (response) in
                
                if(response == "OK"){
                    UserService.saveUserBBVA(user: user!)
                    self.doLoginSucess(user: user!)
                    
                }
                else{
                    self.doLogout()
                    AlertHelper.notificationAlert(title: "Error", message: "Las credenciales son inválidas. Revise sus datos e intente nuevamente.", viewController: self)
                }
            })
        } else {
            //TEST FOR QUBICGO
            UserService.saveUserBBVA(user: "P014773")
            self.doLoginSucess(user: user!)
        }
        
        
    }
    
    func doLoginSucess(user : String ){
        self.saveFirebaseToken(user: user)
        performSegue(withIdentifier: Constants.SIDEBARMENU.gotoDashboard, sender: self)
    }
    
    func saveFirebaseToken(user : String) {
        
        //let token : String = FIRInstanceID.instanceID().token()!
        let newToken : String = "pcurich"
        
        EnrollService.enrollDevice(user: user, token: newToken, completionHandler: {
            (response) in
            
            if(response == "OK"){
                UserDefaults.standard.set(newToken, forKey: "token")
            }
            
        }) 
    }
    
    
    func doLogout(){
        
        UserService.processLogout(completionHandler: {
            (response) in
            
        })
    }
}
#if DEBUG

extension NSURLRequest {
    #if DEBUG
    static func allowsAnyHTTPSCertificate(forHost host: String) -> Bool {
        return true
    }
    #endif
}

#endif

