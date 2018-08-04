//
//  EvaluationVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 8/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class EvaluationVC: BaseVC {
    
    var indicator         = UIActivityIndicatorView()
    let dispatchGroup     = DispatchGroup()
    
    var evaluationList: [EvaluationList] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let cellHeaderIdentifier = "EvaluationAspectHTVC"
    let cellIdentifier       = "EvaluationAspectTVC"
    let segueIdentifier      = "gotoEvaluationDetail"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onMoreTapped(){
        gotoDashBoard()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func onRefresh(_ sender: Any) {
        startView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView()
        self.setupNib()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func startView(){
        activityIndicator()
        startIndicator()
        getEvaluations()
        dispatchGroup.notify(queue: .main){
            self.stopIndicator()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.titleView = setNavegationTitle(title: "Evaluaciones Activas")
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: cellIdentifier)
    }
}

extension EvaluationVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return evaluationList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = Bundle.main.loadNibNamed(cellHeaderIdentifier, owner: self, options: nil)?.first as! EvaluationAspectHTVC
        cell.evaluation = evaluationList[section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (evaluationList[section].aspects.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! EvaluationAspectTVC
        cell.aspect = evaluationList[indexPath.section].aspects[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueIdentifier else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        let cell = segue.destination as! EvaluationDetailsVC
        cell.evaluationAspect =  evaluationList[index.section].aspects[index.row]
    }
    
}


extension EvaluationVC {
    
    func getEvaluations() {
        self.dispatchGroup.enter()
        
        EvaluationService.getEvaluations(register: UserService.getUserBBVA()) {
            (response) in
            
            self.evaluationList = response
            self.dispatchGroup.leave()
        }
    }
}

extension EvaluationVC {
    func activityIndicator() {
        self.indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        self.indicator.transform = CGAffineTransform(scaleX: 4, y: 4)
        self.indicator.center = self.view.center
        self.view.addSubview(self.indicator)
    }
    
    func startIndicator (){
        self.indicator.startAnimating()
        self.indicator.backgroundColor = UIColor.clear
    }
    
    func stopIndicator(){
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
}
