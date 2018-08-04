//
//  AssistanceVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 28/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class AssistanceVC: BaseVC {

    let cellIdentifier = "AssistanceCVC"
    
    var indicator         = UIActivityIndicatorView()
    let dispatchGroup     = DispatchGroup()
    
    var assistance: [AssistanceLine] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func onMoreTapped(){
        gotoDashBoard()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func onRefresh(_ sender: Any) {
        activityIndicator()
        startIndicator()
        getAssistance()
        dispatchGroup.notify(queue: .main){
            self.stopIndicator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator()
        startIndicator()
        getAssistance()
        dispatchGroup.notify(queue: .main){
            self.stopIndicator()
        }
        self.setupNib()
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.titleView = setNavegationTitle(title: "Asistencia por Marcar")
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
    }
    
}

extension AssistanceVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assistance.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    }
    
    //ESTABLECE EL ANCHO Y ALTO DEL CELL
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = Constants.MEDIDAS.LISTACELLL_VIEWHEIGHT * UIScreen.main.bounds.height
        return CGSize.init(width: UIScreen.main.bounds.width-10, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AssistanceCVC
        cell.asistencia = assistance[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = mainStoryBoard.instantiateViewController(withIdentifier: "AssistanceDetailVC") as! AssistanceDetailVC
        destination.assistance = assistance[(indexPath.row)]
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}

// MARK: Prepere dataSource
extension AssistanceVC {
    func getAssistance() {
        self.dispatchGroup.enter()
        AssistanceService.getAssistances(register: UserService.getUserBBVA(), completionHandler: { (response) in
            self.assistance = response
            self.dispatchGroup.leave()
        })
        
    }
}

extension AssistanceVC {
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
