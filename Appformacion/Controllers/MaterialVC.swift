//
//  MaterialVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 30/05/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

class MaterialVC: BaseVC {
    
    let cellIdentifier = "MaterialCVC"
    
    var indicator         = UIActivityIndicatorView()
    let dispatchGroup     = DispatchGroup()
    
    var materials: [MaterialDetail] = [] {
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
        getMaterials()
        dispatchGroup.notify(queue: .main){
            self.stopIndicator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        startIndicator()
        getMaterials()
        dispatchGroup.notify(queue: .main){
            self.stopIndicator()
        }
        self.setupNib()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getMaterials()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.titleView = setNavegationTitle(title: "Materiales Disponibles")
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
    }
    
}

extension MaterialVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materials.count
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MaterialCVC
        cell.material = self.materials[indexPath.row]
        cell.item = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (materials[(indexPath.row)].urlDrive!.count <= 10)   {
            let tipo = materials[(indexPath.row)].type == "CURS" ? "curso" : "programa"
            let str = String.init(format: "El presente %@ no tiene materiales disponibles", tipo)
            AlertHelper.notificationAlert(title: "Materiales no disponible", message: str , viewController: self)
        } else {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let destination = mainStoryBoard.instantiateViewController(withIdentifier: "MaterialDetailVC") as! MaterialDetailVC
            destination.urlDrive = materials[(indexPath.row)].urlDrive!
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
}

extension MaterialVC {
    func getMaterials (){
        self.dispatchGroup.enter()
        MaterialService.getMaterials(register: UserService.getUserBBVA(), completionHandler: { (response) in
            self.materials = response
            self.dispatchGroup.leave()
        })
    }
}

extension MaterialVC {
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
