//
//  PollQuestion2VC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 26/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import Foundation

class PollDetailsVC: BaseVC {
    
    var pollAspect: PollAspect?
    var detailTitle : String?
    var indexQuestion : Int = 0
    var groupPersonId : Int = 0
    var pollResponse = [PollResponse]()
    
    var currentQuestion : PollQuestion! {
        didSet{
            self.lblAspect.text = pollAspect?.description.uppercased()
            self.lblTeacher.text = pollAspect?.teacherName
            
            if (pollAspect?.teacherName == nil){
                layoutHeightTeacher.constant = 0
            }
            
            self.txtQuestion.text = currentQuestion.question
            
            if(self.currentQuestion.note?.count ?? 0 > 0){
               self.lblNote.text = currentQuestion.note
            }else{
                self.layoutHeightNote.constant = 0
            }
            self.collectionView.reloadData()
        }
    }
    
    var indicator     = UIActivityIndicatorView()
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblAspect: UILabel!
    @IBOutlet weak var lblTeacher: UILabel!
    @IBOutlet weak var txtQuestion: UITextView!
    @IBOutlet weak var layoutHeightTeacher: NSLayoutConstraint!
    @IBOutlet weak var layoutHeightNote: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var previousBarButton: UIBarButtonItem!
    @IBOutlet weak var txtSuggestion: UITextView!
    
    @IBOutlet weak var suggestionHeight: NSLayoutConstraint!
    @IBOutlet weak var alternativeHeight: NSLayoutConstraint!
    
    var cellCollectionsIdentifier    = "PollCVC"
    var cellCollectionsIdentifier2   = "PollCVC2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexQuestion = 0
        lblTitle.text = detailTitle
        currentQuestion = pollAspect?.questions[indexQuestion]
        startView()
        
    }
    
    func startView(){
        activityIndicator()
        startIndicator()
        setupNib()
        cleanTitle()
        stopIndicator()
        let stack = alternativeHeight.constant + suggestionHeight.constant
        if(currentQuestion.responseList.count == 1){
            alternativeHeight.constant = 0
            suggestionHeight.constant = stack
        }else{
            suggestionHeight.constant = 0
            alternativeHeight.constant = stack
        }
        
    }
    
    func setupNib(){
        if(currentQuestion.responseList.count == 1){
            let nibCell = UINib(nibName: cellCollectionsIdentifier2, bundle: Bundle.main)
            collectionView.register(nibCell, forCellWithReuseIdentifier: cellCollectionsIdentifier2)
        }else{
            let nibCell = UINib(nibName: cellCollectionsIdentifier, bundle: Bundle.main)
            collectionView.register(nibCell, forCellWithReuseIdentifier: cellCollectionsIdentifier)
        }
    }
    
    @IBAction func previousQuestion(_ sender: UIBarButtonItem) {
        cleanTitle()
        if(indexQuestion>0){
            indexQuestion = indexQuestion - 1
            currentQuestion = pollAspect?.questions[indexQuestion]
        }
        cleanTitle()
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        var isSelected = false
        
        if(currentQuestion.responseList.count == 1){
            isSelected = true
            pollResponse.append(PollResponse(preguntaId: currentQuestion.questionId, rtaId: currentQuestion.responseList[0].responseId, rtadDescription: txtSuggestion.text)) 
        }else{
            for index in 0..<(self.pollAspect?.questions[indexQuestion].responseList.count)!{
                if(self.pollAspect?.questions[indexQuestion].responseList[index].isSelected)!{
                    isSelected = isSelected || (self.pollAspect?.questions[indexQuestion].responseList[index].isSelected)!
                }
            }
        }
        
        
        if(isSelected){
            if(indexQuestion==(pollAspect?.questions.count)!-1){
                // se va a enviar la respuestas
                let alertController = UIAlertController(title: "Guardar Respuestas", message: "Desea guardar las respuestas seleccionadas?", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.updateAnswer()
                    
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data = try! encoder.encode(self.pollResponse)
                    let string = String(data: data, encoding: .utf8)!
                    
                    PollService.save(grupoPersonaId: self.groupPersonId , scheduleId: (self.pollAspect?.scheduleId)!, respuestaEncuesta: string, completionHandler: { (response) in
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
                        self.present(vc, animated: true, completion: nil)
                        
                        var title = "Exito"
                        if response.isError!{
                            title = "Problemas en el envio"
                        }
                        
                        AlertHelper.notificationAlert(title: title, message: response.message!, viewController: vc)
                    })
                }))
                present(alertController, animated: true, completion:nil)
            }else{
                if(indexQuestion<(pollAspect?.questions.count)!-1){
                    indexQuestion = indexQuestion + 1
                    currentQuestion = pollAspect?.questions[indexQuestion]
                }
                cleanTitle()
            }
        }else{
            AlertHelper.notificationAlert(title: "Marque Alternativa", message: "No ha seleccionado una alternativa", viewController: self)
        }
    }
    
    func cleanTitle(){
        nextBarButton.title = "Siguiente"
        previousBarButton.title = "Anterior"
        
        if(indexQuestion == (pollAspect?.questions.count)!-1){
            //el ultimo
            nextBarButton.title = "Finalizar"
            
        }
        if (indexQuestion==0){
            previousBarButton.title = ""
        }
        
    }
    
    func updateAnswer(){
        for question in (self.pollAspect?.questions)!{
            for response in question.responseList{
                if (response.isSelected){
                    pollResponse.append(
                        PollResponse(preguntaId: question.questionId, rtaId: response.responseId,rtadDescription: response.name!)
                    )
                    break
                }
            }
        }
    }
}

extension PollDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.currentQuestion != nil else { return 0 }
        return (self.currentQuestion?.responseList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if(currentQuestion.responseList.count == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCollectionsIdentifier2, for: indexPath) as! PollCVC2
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellCollectionsIdentifier, for: indexPath) as! PollCVC
            let answer = self.pollAspect?.questions[indexQuestion].responseList[indexPath.row]
            cell.alternative = answer
            cell.isSelected = (answer!.isSelected)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<(self.pollAspect?.questions[indexQuestion].responseList.count)!{
            self.pollAspect?.questions[indexQuestion].responseList[index].isSelected = false
        }
        self.pollAspect?.questions[indexQuestion].responseList[indexPath.row].isSelected = true
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if(self.pollAspect?.questions[indexQuestion].responseList.count == 1){
            return CGSize(width: collectionView.bounds.width, height: 120)
        }else{
            var max = 0
            for size in (self.pollAspect?.questions[indexQuestion].responseList)!{
                if (max < (size.value?.count)!){
                    max = (size.value?.count)!
                }
            }
            if (max<3){
                return CGSize(width: collectionView.bounds.width/5 - 20, height: collectionView.bounds.width/5 - 20)
            }
            return CGSize(width: collectionView.bounds.width/2 - 20, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    //para el teclado se puede utilizar esto
    //https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
    
}


extension PollDetailsVC {
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
