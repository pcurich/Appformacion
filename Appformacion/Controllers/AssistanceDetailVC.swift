//
//  AssistanceDetailVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 28/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class AssistanceDetailVC: BaseVC {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var cellIdentifier = "AssistanceDetailTVC"
    var indicator = UIActivityIndicatorView()
    var assistance : AssistanceLine?
    
    var details: [AssistanceDetailLine] = [] {
        didSet {
            tableView.reloadData()
            stopIndicator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        setupViewNibs()
        startIndicator()
        setupDesing()
        getAssistanceDetail()
    }
    
    func setupViewNibs() {
        let myNib = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        tableView.register(myNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func setupDesing(){
        lblTitle.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
    }
    
    @IBAction func SendResponse(_ sender: UIButton) {
        txtCode.isUserInteractionEnabled = false
        setCheckIn()
        if (assistance?.codigo?.uppercased() == txtCode.text?.uppercased()){
            setCheckIn()
        }else{
            AlertHelper.notificationAlert(title: "Error", message: "El código no es correcto", viewController: self)
            txtCode.text = ""
        }
        txtCode.isUserInteractionEnabled = true
    }
    
}

extension AssistanceDetailVC : UITableViewDataSource, UITableViewDelegate    {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AssistanceDetailTVC
        cell.selectionStyle = .none
        cell.detalle = details[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension AssistanceDetailVC {
    
    func activityIndicator() {
        self.indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.indicator.center = self.view.center
        self.view.addSubview(self.indicator)
    }
    
    func startIndicator (){
        self.indicator.startAnimating()
        self.indicator.backgroundColor = UIColor.white
    }
    
    func stopIndicator(){
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
}

// MARK: Prepere dataSource
extension AssistanceDetailVC {
    func getAssistanceDetail() {
        AssistanceService.getAssistanceDetails(register: UserService.getUserBBVA(), salaId:  (assistance?.salaId)!, completionHandler: { (response) in
            self.details = response
        })
    }
    
    func setCheckIn() {
        AssistanceService.checkIn(code: (txtCode.text?.uppercased())! , grpdId: (assistance?.grpdId)!) { (response) in
            if ( response.status == "OK"){
                self.gotoDashBoard()
                self.navigationController?.isNavigationBarHidden = true
                
                AlertHelper.notificationAlert(title: "Éxito", message: response.message!, viewController: self)
                
            }else {
                AlertHelper.notificationAlert(title: "Error", message: response.message!, viewController: self)
            }
        }
    }
}
