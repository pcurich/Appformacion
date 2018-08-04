//
//  InvitationDetailVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 23/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import UserNotifications

class InvitationDetailVC: BaseVC {
    
    var curso : CursosPendientesAceptacion?
    var cellIdentifier = "DetailCalendarTVC"
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTarget: UITextView!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblTitleEvens: UILabel!
    @IBOutlet weak var lblTitleTarget: UILabel!
    
    var listOfType : [InvitacionTipo] = []
    var selectedType = InvitacionTipo(flag: 0, label: "", tipoRespuesta: "")
    
    var details: [CursoDetalle] = [] {
        didSet {
            detailTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        
        setupDesing()
        getDetails()
        getTypes()
        setupViewNibs()
        
    }
    
    func setupDesing(){
        self.lblTitle.text = curso?.nombre
        self.lblTarget.text = curso?.objetivo
        self.lblStartDate.text = curso?.fecha
        self.lblTime.text = (curso?.horas)! + ":" + (curso?.minutos)! + " horas"
        
        self.lblTitleEvens.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1)
        self.lblTitleTarget.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1)
    }
    
    func setupViewNibs() {
        let myNib = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        detailTableView.register(myNib, forCellReuseIdentifier: cellIdentifier)
    }
}

extension InvitationDetailVC : UITableViewDataSource, UITableViewDelegate    {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailCalendarTVC
        cell.selectionStyle = .none
        cell.titleLabel.text = details[indexPath.row].fecha!
        cell.noteLabel.text = details[indexPath.row].sala!
        cell.startTimeLabel.text = details[indexPath.row].horaInicio!
        cell.endTimeLabel.text = details[indexPath.row].horaFinal!
        return cell
    }
    
}

// MARK: PopUp
extension InvitationDetailVC:  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        if let name = listOfType[row].label {
            let myTitle = NSAttributedString(string: name, attributes: [NSAttributedStringKey.font : UIFont(name: "BentonSansBBVA-Book", size: 15.0)!,NSAttributedStringKey.foregroundColor: UIColor.BBVADARKMEDIUMBLUE()])
            pickerLabel.attributedText = myTitle
            pickerLabel.textAlignment = .center
        }
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = listOfType[row]
    }
    
    @IBAction func respondInvitation(_ sender: UIButton) {
        
        let alertView = UIAlertController(
            title: "Responder Invitación",
            message: "\n\n\n\n\n\n",
            preferredStyle: .alert)
        alertView.isModalInPopover = true
        
        let pickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        alertView.view.addSubview(pickerView)
        let ok = UIAlertAction(title: "Enviar", style: .default, handler: {
            (UIAlertAction) in
            
            InvitationService.responseInvitation(grupoId: (self.curso?.grupoId!)!, tipoRespuesta: self.selectedType.tipoRespuesta!, flag: self.selectedType.flag!, completionHandler: { (response) in
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                for detail in self.details {
                    self.Schedule(title: self.lblTitle.text!, detalle: detail )
                }
   
                if ( response){
                    self.gotoDashBoard()
                    self.navigationController?.isNavigationBarHidden = true
                    
                    AlertHelper.notificationAlert(title: "Éxito", message: "Se registro correctamente", viewController: self)
                    
                }else {
                    AlertHelper.notificationAlert(title: "Error", message: "Sucedio un error, inténtelo en un momento", viewController: self)
                }
            })
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in }
        
        alertView.addAction(ok)
        alertView.addAction(cancel)
        present(alertView, animated: true)
        
    }
    
}

// MARK: Prepere dataSource
extension InvitationDetailVC {
    func getDetails() {
        InvitationService.getDetails(horarioId: (curso?.horarioId)!) { (response) in
            self.details = response
        }
    }
    
    func getTypes() {
        InvitationService.getResponseList() { (response) in
            self.listOfType = response
            self.selectedType = self.listOfType[0]
        }
        
    }
}


extension InvitationDetailVC : UNUserNotificationCenterDelegate {
    
    
    func Schedule(title: String ,detalle : CursoDetalle ) {
        
        let strDate = detalle.fecha! + " " + detalle.horaInicio!
      
        let formatter = "dd/MM/yyyy hh:mm"
        let calendar = Calendar.current
        let date = CustomHelper.toDate(str: strDate , formate: formatter)
        
        var dateComponent = DateComponents()
        dateComponent.year   = calendar.component(.year  , from: date)
        dateComponent.month  = calendar.component(.month , from: date)
        dateComponent.day    = calendar.component(.day   , from: date)
        dateComponent.hour   = calendar.component(.hour  , from: date)
        dateComponent.minute = calendar.component(.minute, from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let contenido = UNMutableNotificationContent()
        contenido.title = "Recordatorio"
        contenido.subtitle = title
        contenido.body = "Recordatorio para la asistencia que se llevara a cabo en: " + detalle.sala!
        contenido.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: detalle.fechaInicioFormato!, content: contenido, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("fallo la notificacion", error)
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
}
