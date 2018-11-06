//
//  MenuBBVA2.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 2/10/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//
import UIKit

struct MenuHeader2 {
    let title : String!
    var menu : [MenuBBVA2] = []
    
    init(title: String, menu : [MenuBBVA2]) {
        self.title = title
        self.menu = menu
    }
    
    static func getMenu() -> [MenuHeader2]{
        var t = [MenuHeader2]()
        t.append(MenuHeader2(title: "",menu: MenuBBVA2.getMenuHome()))
        t.append(MenuHeader2(title: "Formación",menu: MenuBBVA2.getMenuFormacion()))
        t.append(MenuHeader2(title: "Recursos",menu: MenuBBVA2.getMenuRecurso()))
        t.append(MenuHeader2(title: "Comunidades",menu: MenuBBVA2.getMenuComunidades()))
        t.append(MenuHeader2(title: "Cerrar Sesión",menu: MenuBBVA2.getMenuCerrar()))
        return t
    }
}

struct MenuBBVA2 {
    let name : String!
    let order: Int!
    let goto : String!
    let image: UIImageView!
    
    init(name: String, order: Int, goto : String, image : UIImage)   {
        self.name = name
        self.order = order
        self.goto  = goto
        self.image = UIImageView(image: image)
    }
    
    static func getMenuHome()-> [MenuBBVA2]{
        var t = [MenuBBVA2]()
        t.append(MenuBBVA2(name: "Home",order: 1,
                           goto: Constants.SIDEBARMENU.gotoDashboard ,
                           image: UIImage(named:"ic_home")!))
        return t;
    }
    
    static func getMenuFormacion()-> [MenuBBVA2]{
        var t = [MenuBBVA2]()
        
        t.append(MenuBBVA2(name: "Invitaciones",order: 1,
                           goto: Constants.SIDEBARMENU.goToInvitaciones,
                           image: UIImage(named:"ic_menu_mail")!))
        
        t.append(MenuBBVA2(name: "Actividades",order: 2,
                           goto: Constants.SIDEBARMENU.gotoActividades,
                           image: UIImage(named:"ic_menu_program")!))
        
        t.append(MenuBBVA2(name: "Asistencias",order: 3,
                           goto: Constants.SIDEBARMENU.gotoAsistencia,
                           image: UIImage(named:"ic_menu_time")!))
        
        t.append(MenuBBVA2(name: "Evaluación",order: 4,
                           goto: Constants.SIDEBARMENU.gotoEvaluaciones,
                           image: UIImage(named:"ic_menu_burger")!))
        
        t.append(MenuBBVA2(name: "Encuestas",order: 5,
                           goto: Constants.SIDEBARMENU.gotoEncuestas,
                           image: UIImage(named:"ic_menu_back")!))
        
        return t
    }
    
    static func getMenuRecurso()-> [MenuBBVA2]{
        var t = [MenuBBVA2]()
        t.append(MenuBBVA2(name: "Google Drive",order: 1,
                           goto: Constants.SIDEBARMENU.gotoMateriales,
                           image: UIImage(named:"ic_menu_drive")!))
        
        t.append(MenuBBVA2(name: "Calendarios",order: 2,
                           goto: Constants.SIDEBARMENU.gotoCalendario,
                           image: UIImage(named:"ic_menu_cal")!))
        return t
    }
    
    static func getMenuComunidades()-> [MenuBBVA2]{
        var t = [MenuBBVA2]()
        t.append(MenuBBVA2(name: "Google+",order: 1,
                           goto: Constants.SIDEBARMENU.gotoGooglePlus,
                           image: UIImage(named:"ic_menu_google")!))
        
        t.append(MenuBBVA2(name: "Campus BBVA",order: 2,
                           goto: Constants.SIDEBARMENU.gotoCampus,
                           image: UIImage(named:"ic_menu_formation")!))
        return t
    }
    
    static func getMenuCerrar()-> [MenuBBVA2]{
        var t = [MenuBBVA2]()
        t.append(MenuBBVA2(name: "Cerrar Sesión",order: 1,
                           goto: Constants.SIDEBARMENU.gotoCerrar,
                           image: UIImage(named:"ic_logout")!))
        return t
    }
    
    
}
