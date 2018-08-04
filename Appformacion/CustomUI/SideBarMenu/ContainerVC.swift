//
//  ContainerVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 1/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    @IBOutlet weak var sideBarMenuConstraint : NSLayoutConstraint!
    @IBOutlet weak var vwPrincipal: UIView!
    @IBOutlet weak var vwSideBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Muestroa la barra de menu
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideBarMenu), name: NSNotification.Name(Constants.SIDEBARMENU.showSideBarMenu), object: nil)
    }
    
    @objc func toggleSideBarMenu(){
        if (self.sideBarMenuConstraint.constant == 0){
            self.sideBarMenuConstraint.constant = -250
        }else {
            self.sideBarMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            DispatchQueue.main.async {
                self.vwSideBar.layoutIfNeeded()
                self.vwPrincipal.layoutIfNeeded()
                self.view.layoutIfNeeded()
                self.view.updateConstraints()
            }
        }
        
    }
}
