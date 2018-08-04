//

//  DashboardViewController.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 14/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class DashboardVC : BaseVC{

    var indicator         = UIActivityIndicatorView()
    let dispatchGroup     = DispatchGroup()

    @IBOutlet weak var leftLayout: NSLayoutConstraint!
    @IBOutlet weak var rightLayout: NSLayoutConstraint!
    @IBOutlet weak var heightLayout: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Helpers
    let cellIdentifier = "ButtonCVC"
    var dashboard: [Dashboard] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBAction func onMoreTapped(){
        NotificationCenter.default.post(name: NSNotification.Name(Constants.SIDEBARMENU.showSideBarMenu), object: nil)
    }
    
    @IBAction func onRefresh(_ sender: Any) {
        activityIndicator()
        startIndicator()
        getDashboard()
        dispatchGroup.notify(queue: .main){
            self.setupCollectionView()
            self.stopIndicator()
        }
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.titleView = setNavegationTitle(title: "Home") 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        startIndicator()
        getDashboard()
        dispatchGroup.notify(queue: .main){
            self.setupCollectionView()
            self.stopIndicator()
        }
        setupNib()
        
        // se le esta seteando los valores de los identificadores para cada
        //
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAct),
                                               name: NSNotification.Name(Constants.SIDEBARMENU.gotoActividades), object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showInv),
                                               name: NSNotification.Name(Constants.SIDEBARMENU.goToInvitaciones), object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showCal),
                                               name: NSNotification.Name(Constants.SIDEBARMENU.gotoCalendario), object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAsi),
                                               name: NSNotification.Name(Constants.SIDEBARMENU.gotoAsistencia), object: nil)
     
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setupCollectionView () {
        let layout = self.collectionView.collectionViewLayout  as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: (self.collectionView.frame.size.height)/3)
        
        if (UIScreen.main.bounds.width <= 320){
            rightLayout.constant = -50
            leftLayout.constant = 50
            heightLayout.constant = 100
        }else{
            rightLayout.constant = 0
            leftLayout.constant = 0
            heightLayout.constant = 150
        }
        
    }
   
    @objc func showAct(){
        performSegue(withIdentifier: Constants.SIDEBARMENU.gotoActividades, sender: nil)
    }
    
    @objc func showInv(){
        performSegue(withIdentifier: Constants.SIDEBARMENU.goToInvitaciones, sender: nil)
    }
    
    @objc func showCal(){
        performSegue(withIdentifier: Constants.SIDEBARMENU.gotoCalendario, sender: nil)
    }
    
    @objc func showAsi(){
        performSegue(withIdentifier: Constants.SIDEBARMENU.gotoAsistencia, sender: nil)
    }
    
}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboard.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let width = UIScreen.main.bounds.width
        return UIEdgeInsets(top: 0, left: 0.1*width, bottom: 0, right: 0.1*width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cheight = CGFloat(Constants.MEDIDAS.L_DASHBOARD * UIScreen.main.bounds.height)
        let cwidth   = CGFloat(Constants.MEDIDAS.A_DASHBOARD * UIScreen.main.bounds.width)
        return CGSize.init(width: cwidth , height: cheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ButtonCVC
        cell.dashboard = dashboard[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: dashboard[indexPath.item].goto!, sender: self)
    }
}

// MARK: Prepere dataSource
extension DashboardVC {
    func getDashboard() {
        self.dispatchGroup.enter()
        DashboardService.getDashboard(register: UserService.getUserBBVA(), completionHandler: { (response) in
            self.dashboard = response
        })
        self.dispatchGroup.leave()
    }
}

extension DashboardVC {
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
