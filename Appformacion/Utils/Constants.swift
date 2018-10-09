//
//  Constants.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 14/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct REST {
        
        static let test = "t"
        static let cali = "c"
        static let prod = "p"
        static let qugo = "qg"
        
        static let environment = qugo
        
        static let path_Test = "extranetdev"
        static let path_Cali = "extranetdev"
        static let path_Prod = "extranetperu"
        static let path_QuGo = "190.117.253.189"
        
        static let port_Test = "10443"
        static let port_Cali = "11443"
        static let port_Prod = "10443"
        static let port_QuGo = "8589" //casa de java 8588
        
        static let path = (environment == test) ? path_Test :
            (environment == cali) ? path_Cali :
            (environment == prod) ? path_Prod : path_QuGo
        
        static let port = (environment == test) ? port_Test :
            (environment == cali) ? port_Cali :
            (environment == prod) ? port_Prod : port_QuGo
        
        static let ip_QuGo = "http://\(path):\(port)"
        static let ip_Bbva = "https://\(path).grupobbva.pe:\(port)/\(environment)jboss8485/appformacionbg"
        
        static let ip = ip_QuGo
        static let useLogin = false
        
        static let login = "https://\(path).grupobbva.pe:\(port)/pkmslogin.form"
        static let logout = "https://\(path).grupobbva.pe:\(port)/pkmslogout.form"
        
    }
    
    struct WEBSERVICE {
        static let enroll = "\(Constants.REST.ip)/enrolarDispositivo"
        static let calendar = "\(Constants.REST.ip)/obtenerCalendario"
        static let dashboard = "\(Constants.REST.ip)/obtenerDashboarInfo"
        
        
        static let invitations = "\(Constants.REST.ip)/obtenerInvitacionesActivas"
        static let invitationDetails = "\(Constants.REST.ip)/obtenerSalaDisponibilidadInvitaciones"
        static let invitationsResponseList = "\(Constants.REST.ip)/obtenerConfiguracionInvitacionActiva"
        static let responderInvitacion = "\(Constants.REST.ip)/recepcionRespuestInvitacion"
        
        static let activities = "\(Constants.REST.ip)/obtenerActividadesProgramadas"
        static let activitiesDetails = "\(Constants.REST.ip)/obtenerActividadesProgramadasDetalle"
        
        static let assistences = "\(Constants.REST.ip)/obtenerAsistenciaXMarcar"
        static let assistenceDetails = "\(Constants.REST.ip)/obtenerAsistenciaXMarcarDetalle"
        static let checkIn =  "\(Constants.REST.ip)/marcarAsistencia"
        
        static let materials = "\(Constants.REST.ip)/obtenerUrlDrive"
        static let settingPolls = "\(Constants.REST.ip)/buscarConfiguracionEncuestas"
        
        static let polls = "\(Constants.REST.ip)/buscarEncuestasPendientes"
        static let pollResponse = "\(Constants.REST.ip)/obtenerRepuestaEncuestas"
        
        static let evaluations = "\(Constants.REST.ip)/obtenerEvaluaciones"
        static let evaluationResponse = "\(Constants.REST.ip)/recepcionRespuestaEvaluacion"
        
    }
    
    struct SIDEBARMENU {
        static let showSideBarMenu = "toggleSideBarMenu"
        
        static let gotoDashboard = "gotoDas"
        
        static let goToInvitaciones = "gotoInv"
        static let gotoActividades = "gotoAct"
        static let gotoAsistencia = "gotoAsi"
        static let gotoEvaluaciones = "gotoEva"
        static let gotoEncuestas = "gotoEnc"
        
        static let gotoMateriales = "gotoMat"
        static let gotoCalendario = "gotoCal"
        
        static let gotoGooglePlus = "gotoPls"
        static let gotoCampus = "gotoCmp"
        
        static let gotoCerrar = "gotoCls"
        
    }
    
    struct MEDIDAS {
        static let 	L_LINEAHORIZONTAL = 2.273
        static let  L_TABLEROPRINCIPAL = 37.879
        static let  L_CAJATEXTO = 6.061
        static let  L_LABELTITULO = 3.030
        static let  L_BOTONES = 6.061
        static let  AL_TABLEROBOTON = 27.027
        static let  A_ESPACIOTABLEROBOTON = 9.459
        static let  L_ESPACIOTABLEROBOTON = 0
        
        static let  L_LISTACELLL_INSET_TOP = 3.788/100
        
        static let L_LISTACELLL_SCUARE_TOP   = 2.273
        static let L_LISTACELLL_SCUARE_LEFT  = 2.273
        static let L_LISTACELLL_SCUARE_RIGHT = 2.273
        static let L_LISTACELLL_SCUARE_BUTTO = 2.273

        static let LISTACELLL_VIEWHEIGHT = CGFloat(16.67/100)
        
        static let LISTACELLL_TO_SCUARE_TOP = CGFloat(16.67/100)
        static let LISTACELLL_TO_SCUARE_LEFT = CGFloat(16.67/100)
        static let LISTACELLL_TO_SCUARE_RIGHT = CGFloat(16.67/100)
        static let LISTACELLL_TO_SCUARE_BUTTOM = CGFloat(16.67/100)
        
        
        static let L_DASHBOARD = CGFloat(20.00/100)
        static let A_DASHBOARD = CGFloat(38.00/100)
        
    }
}
