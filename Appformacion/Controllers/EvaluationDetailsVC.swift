//
//  EvaluationQuestionVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 8/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import SwiftyJSON

class EvaluationDetailsVC: BaseVC {
    
    var evaluationResponse = [EvaluationResponse]()
    var evaluationAspect: EvaluationAspect?
    var indexQuestion : Int = 0
    
    @IBOutlet weak var txtQuestion: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var questionHeight: NSLayoutConstraint!
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var previousBarButton: UIBarButtonItem!
    
    var cellCollectionsIdentifier    = "EvaluationCVC"
    
    var currentQuestion : EvaluationQuestion! {
        didSet{
            txtQuestion.text = self.evaluationAspect?.questions[indexQuestion].question
            self.collectionView.reloadData()
        }
    }
    
    var indicator     = UIActivityIndicatorView()
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexQuestion = 0
        txtQuestion.text = self.evaluationAspect?.questions[indexQuestion].question
        currentQuestion = self.evaluationAspect?.questions[indexQuestion]
        questionHeight.constant = UIScreen.main.bounds.size.height * 0.4
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        startView()
    }
    
    func startView(){
        activityIndicator()
        startIndicator()
        setupNib()
        cleanTitle()
        stopIndicator()
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellCollectionsIdentifier, bundle: Bundle.main)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellCollectionsIdentifier)
    }
    
    @IBAction func previousQuestion(_ sender: UIBarButtonItem) {
        cleanTitle()
        if(indexQuestion>0){
            indexQuestion = indexQuestion - 1
            currentQuestion = evaluationAspect?.questions[indexQuestion]
        }
        cleanTitle()
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        var isSelected = false
        for index in 0..<(self.evaluationAspect?.questions[indexQuestion].responseList.count)!{
            if(self.evaluationAspect?.questions[indexQuestion].responseList[index].isSelected)!{
                isSelected = isSelected || (self.evaluationAspect?.questions[indexQuestion].responseList[index].isSelected)!
            }
        }
        
        if(isSelected){
            if(indexQuestion==(evaluationAspect?.questions.count)!-1){
                // se va a enviar la respuestas
                let alertController = UIAlertController(title: "Guardar Respuestas", message: "Desea guardar las respuestas seleccionadas?", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                    self.CreateResponse()
                    
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data = try! encoder.encode(self.evaluationResponse)
                    let string = String(data: data, encoding: .utf8)!
                    
                    EvaluationService.save(grppId: (self.evaluationAspect?.aspectId)!,
                                           respuestaEvaluacion:string,
                                           completionHandler: { (response) in
                                            
                                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            let vc = storyboard.instantiateViewController(withIdentifier: "EvaluationResultVC") as! EvaluationResultVC
                                            
                                            vc.goodAnswer = self.getGoodAnswer()
                                            vc.badAnswer = self.getBadAnswer()
                                            vc.percent = (self.evaluationAspect?.percent)!
                                            
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
                if(indexQuestion<(evaluationAspect?.questions.count)!-1){
                    indexQuestion = indexQuestion + 1
                    currentQuestion = evaluationAspect?.questions[indexQuestion]
                }
                cleanTitle()
            }
        }else{
            AlertHelper.notificationAlert(title: "Marque Alternativa", message: "No ha seleccionado una alternativa", viewController: self)
        }
        
    }
    
    func getGoodAnswer() -> [EvaluationQuestion]{
        //todo hacer el split de las contestadas bien
        var good = [EvaluationQuestion]()
        for q in (self.evaluationAspect?.questions)!{
            
            var alternative = [EvaluationAnswer]()
            for r in q.responseList {
                if (r.responseType=="RPTA_COR" && r.isSelected)
                {
                    alternative.append(EvaluationAnswer(description: r.description,responseType: r.responseType))
                }
            }
            if(alternative.count>0){
                good.append(EvaluationQuestion(questionId: q.questionId,
                                               question: q.question,
                                               responseList: alternative))
            }
        }
        return good
    }
    
    func getBadAnswer() -> [EvaluationQuestion]{
        
        var bad = [EvaluationQuestion]()
        for q in (self.evaluationAspect?.questions)!{
            var alternative = [EvaluationAnswer]()
            for r in q.responseList {
                if ((r.responseType == "RPTA_INC" && r.isSelected) ||
                    r.responseType == "RPTA_COR" && !r.isSelected)
                {
                    alternative.append(EvaluationAnswer(description: r.description,responseType: r.responseType))
                }
            }
            if(alternative.count>1){ // la correcta como minimo pero tiene que haber incorrectas
                bad.append(EvaluationQuestion(questionId: q.questionId,
                                              question: q.question,
                                              responseList: alternative))
            }
        }
        return bad
    }
    
    func CreateResponse(){
        for q in (self.evaluationAspect?.questions)!{
            var alternative = [Int]()
            var wasOk = true
            for a in q.responseList{
                if(a.isSelected){
                    alternative.append(a.responseId)
                    if (a.responseType == "RPTA_COR"){
                        wasOk = wasOk && true
                    }else{
                        wasOk = wasOk && false
                    }
                }
            }
            //if(alternative.count > 0){ No lo stoy validando porque siempre debe marcar algo
            evaluationResponse.append(EvaluationResponse(preguntaId: q.questionId, codPregunta: q.responseType, respuestas: alternative, esCorrecto: wasOk))
            //}
            
        }
    }
    
    func cleanTitle(){
        nextBarButton.title = "Siguiente"
        previousBarButton.title = "Anterior"
        
        if(indexQuestion == (evaluationAspect?.questions.count)!-1){
            //el ultimo
            nextBarButton.title = "Finalizar"
            
        }else{
            if (indexQuestion==0){
                previousBarButton.title = ""
            }
        }
    }
}

extension EvaluationDetailsVC: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.currentQuestion != nil else { return 0 }
        return (self.currentQuestion?.responseList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCollectionsIdentifier, for: indexPath) as! EvaluationCVC
        let answer = self.evaluationAspect?.questions[indexQuestion].responseList[indexPath.row]
        cell.alternative = answer
        cell.responseType = (self.evaluationAspect?.questions[indexQuestion].responseType)!
        cell.isSelected = (answer!.isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.evaluationAspect?.questions[indexQuestion].responseType == "OPC_SIM"){
            for index in 0..<(self.evaluationAspect?.questions[indexQuestion].responseList.count)!{
                self.evaluationAspect?.questions[indexQuestion].responseList[index].isSelected = false
            }
            self.evaluationAspect?.questions[indexQuestion].responseList[indexPath.row].isSelected = true
            self.collectionView.reloadData()
        }else{
            let before = (self.evaluationAspect?.questions[indexQuestion].responseList[indexPath.row].isSelected)!
            self.evaluationAspect?.questions[indexQuestion].responseList[indexPath.row].isSelected = !before
            self.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}

extension EvaluationDetailsVC {
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

