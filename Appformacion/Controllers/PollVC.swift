//
//  PollVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 4/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class PollVC: BaseVC {
    
    var indicator         = UIActivityIndicatorView()
    let dispatchGroup     = DispatchGroup()
    
    var pollList: [PollList] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let cellHeaderIdentifier = "PollAspectHTVC"
    let cellIdentifier       = "PollAspectTVC"
    let segueIdentifier      = "gotoPollDetail"
    
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
        getSetting()
        getPolls()
        dispatchGroup.notify(queue: .main){
            self.stopIndicator()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.titleView = setNavegationTitle(title: "Encuestas Activas")
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: cellIdentifier)
    }
    
}

extension PollVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pollList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = Bundle.main.loadNibNamed(cellHeaderIdentifier, owner: self, options: nil)?.first as! PollAspectHTVC
        cell.poll = pollList[section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pollList[section].aspects.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PollAspectTVC
        cell.aspect = pollList[indexPath.section].aspects[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueIdentifier else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        let cell = segue.destination as! PollDetailsVC
        cell.detailTitle = pollList[index.section].name
        cell.pollAspect =  pollList[index.section].aspects[index.row]
        cell.groupPersonId = pollList[index.section].groupPersonId
    }
}

extension PollVC {
    func getSetting (){
        self.dispatchGroup.enter()
        PollService.updateConfig()
        self.dispatchGroup.leave()
    }
    
    func getPolls(){
        self.dispatchGroup.enter()
        PollService.getPolls(register: UserService.getUserBBVA()) { (response) in
            self.pollList = response
            self.dispatchGroup.leave()
        }
        
    }
}

extension PollVC {
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
