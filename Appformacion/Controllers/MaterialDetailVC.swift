//
//  MaterialDetailVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 30/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import WebKit

class MaterialDetailVC: BaseVC {
    var indicador : UIActivityIndicatorView!
    
    var urlDrive : String = ""
    @IBOutlet weak var webKit: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startActivity()
        
        //DispatchQueue.main.async {
            
            let url = URL(string: self.urlDrive)
            let request = URLRequest(url: url!)
            
            self.webKit.load(request)
        //}
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.stopActivity()
    }
    
}

extension MaterialDetailVC {
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
