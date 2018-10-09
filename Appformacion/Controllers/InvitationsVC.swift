//
//  InvitationsVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 21/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class InvitationsVC: BaseVC {
    
    let cellIdentifier    = "InvitationsCVC"
    
    var indicator         = UIActivityIndicatorView()
    let dispatchGroup     = DispatchGroup()
    
    var invitations: [CursosPendientesAceptacion] = [] {
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
        getInvitations()
        dispatchGroup.notify(queue: .main){
            self.stopIndicator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator()
        startIndicator()
        getInvitations()
        dispatchGroup.notify(queue: .main){
            self.stopIndicator()
        }
        self.setupNib()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.titleView = setNavegationTitle(title: "Invitaciones por Responder")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getInvitations()
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
    }
    
}

extension InvitationsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invitations.count
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! InvitationsCVC
        cell.invitation = invitations[indexPath.row]
        cell.item = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = mainStoryBoard.instantiateViewController(withIdentifier: "InvitationDetailVC") as! InvitationDetailVC
        destination.curso = invitations[(indexPath.row)]
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}

// MARK: Prepere dataSource
extension InvitationsVC {
    func getInvitations() {
        self.dispatchGroup.enter()
        InvitationService.getInvitations(register: UserService.getUserBBVA(), completionHandler: { (response) in
            self.invitations = response
            self.dispatchGroup.leave()
        })
        
    }
}
extension InvitationsVC {
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

//https://github.com/betranthanh/ios-swift-uicollectionviewcell-from-xib/blob/master/README.md
