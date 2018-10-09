//
//  SideBarMenuTVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 1/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleSignIn

class SideBarMenuTVC: UITableViewController {
    
    let cellIdentifier = "MenuTVC"
    let cellHeaderIdentifier = "MenuHTVC"
    
    /*
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var imgImagen: UIImageView!
    @IBOutlet weak var gooSignIn: GIDSignInButton!
    @IBOutlet weak var gooSignOut: UIButton!
    */
    var headerMenu : [MenuHeader2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNib()
        getMenu()
        //getSetup()
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for m in headerMenu[indexPath.section].menu
        {
            if m.order == (indexPath.row + 1) {
                NotificationCenter.default.post(name: NSNotification.Name(m.goto), object: nil)
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(Constants.SIDEBARMENU.showSideBarMenu), object: nil)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (headerMenu[section].menu.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var item : MenuBBVA2!
        
        for m in headerMenu[indexPath.section].menu {
            if m.order == (indexPath.row + 1)
            {
                item = m
                break
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ) as? MenuTVC
        {
            cell.item = item
            return cell
        }
        return UITableViewCell()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerMenu.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = Bundle.main.loadNibNamed(cellHeaderIdentifier, owner: self, options: nil)?.first as! MenuHTVC
        cell.menuHeader = headerMenu[section]
        return cell
    }
}

extension SideBarMenuTVC  {
    func getMenu(){
        /*
         let _menu = RealmService.shared.realm.objects(MenuBBVA.self)
         for i in _menu {
         menu.append(
         MenuBBVA(visible: i.visible, name: i.name, order: i.order, goto: i.goto))
         }
         */
        headerMenu = MenuHeader2.getMenu()
    }
    
    /*
    func getSetup(){ 
        imgImagen.setRounded()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        DispatchQueue.main.async {
            if (UserService.getUserGOOGLE() != nil){
                let data = UserService.getUserGOOGLE()?.imagen!
                self.imgImagen.image = UIImage(data: data!)!
                self.imgImagen.setNeedsDisplay()
                self.gooSignIn.isHidden = true
                self.gooSignOut.isHidden = false
            }else{
                self.gooSignIn.isHidden = false
                self.gooSignOut.isHidden = true
            }
            
        }
    }
 */
}
/*
extension SideBarMenuTVC : GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error en el login",error.localizedDescription)
        }else{
            let data = try? Data(contentsOf: user.profile.imageURL(withDimension: 100))
            UserService.saveUserGOOGLE(name: user.profile.name, email: user.profile.email, imagen: data!)
            
            DispatchQueue.main.async {
                if (UserService.getUserGOOGLE() != nil){
                    let data = UserService.getUserGOOGLE()?.imagen!
                    self.imgImagen.image = UIImage(data: data!)!
                    self.imgImagen.setNeedsDisplay()
                    self.gooSignIn.isHidden = true
                    self.gooSignOut.isHidden = false
                }else {
                    self.gooSignIn.isHidden = false
                    self.gooSignOut.isHidden = true
                }
            }
        }
    }
 
 @IBAction func salir(_ sender: Any) {
 closeSesion()
 UserService.deleteUserGOOGLE()
 }
 
    func closeSesion(){
        GIDSignIn.sharedInstance().signOut()
        gooSignIn.isHidden = true
        gooSignOut.isHidden = false
        dismiss(animated: true, completion: nil)
    }
    
 
}
*/
