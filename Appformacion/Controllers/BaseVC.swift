//
//  BaseVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 18/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    var reachability : Reachability!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // le establece al delegado quien es la vista actual a fin de que
        // este sepa en que vista se encunetra
        (UIApplication.shared.delegate as! AppDelegate).currentViewController = self
        
        reachability = Reachability.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(conexion), name: Notification.Name.reachabilityChanged, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch   {
            print("Ha sucedido un error en la lectura de la conexion del celular")
        }
    }
    
    @objc func conexion (nota: Notification){
        let reach = nota.object as! Reachability
        
        if reach.connection == .none {
            AlertHelper.notificationAlert(title: "No hay conexion", message: "Su dispositivo no se encuentra conectado a internet, restablezca la conexión para seguir utilizando el app", viewController: self)
        }
    }
    
    func close(){
        
        //https://freakycoder.com/ios-notes-19-how-to-push-and-present-to-viewcontroller-programmatically-how-to-switch-vc-8f8f65b55c7b
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        self.present(nextViewController, animated: true, completion: nil)
        
        AlertHelper.notificationAlert(title: "Error", message: "Su sesión ha expirado. Ingrese nuevamente.", viewController: nextViewController)
        
        //safe  present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC{
            present(vc, animated: true, completion: nil)
        }
    }
    
    func getRegistro() -> String {
        return UserService.getUserBBVA()   
    }
    
    func gotoDashBoard(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContainerVC")
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    func setNavegationTitle(title:String) -> UILabel{
        let lbNavTitle = UILabel (frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 40))
        lbNavTitle.textColor = UIColor.white
        lbNavTitle.backgroundColor = UIColor.clear
        lbNavTitle.numberOfLines = 0
        lbNavTitle.center = CGPoint(x: 0, y: 0)
        lbNavTitle.textAlignment = .left
        lbNavTitle.text = title
        return lbNavTitle
    }
}


