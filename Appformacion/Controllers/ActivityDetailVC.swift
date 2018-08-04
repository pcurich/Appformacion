//
//  ActivityDetailVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 27/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import Social

class ActivityDetailVC: UIViewController {
    
    var actividad : ActividadesProgramadas?
    var cellIdentifier = "DetailActivityTVC"
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTarget: UITextView!
    
    @IBOutlet weak var lblTitleEvens: UILabel!
    @IBOutlet weak var lblTitleTarget: UILabel!

    
    var details: [ActividadDetalle] = [] {
        didSet {
            detailTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesing()
        getDetails()
        setupViewNibs()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareSocialMedia))
    }
    
    func setupDesing(){
        
        self.lblTitle.text = actividad?.nombre
        self.lblTarget.text = actividad?.objetivo
        self.lblTitleEvens.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1)
        self.lblTitleTarget.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1)
    }
    
    func setupViewNibs() {
        let myNib = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        detailTableView.register(myNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc func shareSocialMedia() {

        let shared = UIActivityViewController(activityItems: [actividad?.hashTag!,#imageLiteral(resourceName: "fondo")], applicationActivities: nil)
         present(shared, animated: true, completion: nil)
 
    }
    
    func errorSocial(serviceType: String){
        
        let alert = UIAlertController(title: "No Disponible", message: "Su dispositivo no esta conectado a \(serviceType)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
    }
 
}

extension ActivityDetailVC : UITableViewDataSource, UITableViewDelegate    {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailActivityTVC
        cell.selectionStyle = .none
        cell.detalle = details[indexPath.row]
        return cell
    }
    
}

// MARK: Prepere dataSource
extension ActivityDetailVC {
    func getDetails() {
        ActivityService.getDetails(grupoPersonaId: (actividad?.grupoPersonaId)!) { (response) in
            self.details = response
        }
    }
 
}
