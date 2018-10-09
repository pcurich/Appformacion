//
//  CampusVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 2/10/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import WebKit

class CampusVC: BaseVC {
    var indicador : UIActivityIndicatorView!
    
    var urlDrive : String = ""
    @IBOutlet weak var webKit: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startActivity()
        
        let url = URL(string: "http://www.campusbbva.com")
        let request = URLRequest(url: url!)
        
        self.webKit.load(request)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.stopActivity()
    }
    
}

extension CampusVC {
    func startActivity(){
        self.indicador = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        self.indicador.center = self.view.center
        self.indicador.hidesWhenStopped = false
        self.indicador.startAnimating()
        self.view.addSubview(indicador)
        
    }
    
    func stopActivity(){
        if (self.indicador != nil){
            self.indicador.stopAnimating()
            self.indicador.removeFromSuperview()
        }
    }
}
