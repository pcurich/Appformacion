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
    
    var goodAnswer = [EvaluationQuestion]()
    var badAnswer = [EvaluationQuestion]()
    
    @IBOutlet weak var txtQuestion: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
                
                self.goodAnswer = self.getGoodAnswer()
                self.badAnswer  = self.getBadAnswer()
                
                let cancelAction = UIAlertAction(title: "Cancelar", style: .default) { _ in
                    
                }
                
                let okAction = UIAlertAction(title: "Enviar", style: .default, handler: { (action: UIAlertAction!) in
                    
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
                                            
                                            vc.goodAnswer = self.goodAnswer
                                            vc.badAnswer = self.badAnswer
                                            
                                            vc.percent = (self.evaluationAspect?.percent)!
                                            
                                            self.present(vc, animated: true, completion: nil)
                                            
                                            var title = "Exito"
                                            if response.isError!{
                                                title = "Problemas en el envio"
                                            }
                                            AlertHelper.notificationAlert(title: title, message: response.message!, viewController: vc)
                    })
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
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
    
    func getBadAnswer() -> [EvaluationQuestion]{
        
        var bad = [EvaluationQuestion]()
        
        for q in (self.evaluationAspect?.questions)!{
            var alternative = [EvaluationAnswer]()
            
            if (q.responseType == "OPC_SIM"){
                for r in q.responseList {
                    if (r.responseType=="RPTA_COR" && !r.isSelected){
                        alternative.append(EvaluationAnswer(r.responseId, r.description + " (Correcto)", r.responseType))
                    }
                    if (r.responseType=="RPTA_INC" && r.isSelected){
                        alternative.append(EvaluationAnswer(r.responseId, r.description + " (Error)", r.responseType))
                    }
                }
                if alternative.count > 0 {
                    bad.append(EvaluationQuestion(questionId: q.questionId, question: q.question, responseList: alternative))
                    alternative.removeAll()
                    alternative = [EvaluationAnswer]()
                }
            }else{
                let temp = getCorrectAnswer(question: q)
                for r in temp {
                    if (r.responseType=="RPTA_COR" && r.isSelected){
                        alternative.append(EvaluationAnswer(r.responseId, r.description + " (Seleccionado)", r.responseType))
                    }else if (r.responseType=="RPTA_COR" && !r.isSelected){
                        alternative.append(EvaluationAnswer(r.responseId, r.description + " (No Seleccionado)",r.responseType))
                    }
                    else{
                        alternative.append(EvaluationAnswer(r.responseId,r.description + " (No Seleccionado)", "RPTA_INC"))
                    }
                }
                for r in q.responseList {
                    if (r.responseType=="RPTA_INC" && r.isSelected){
                        alternative.append(EvaluationAnswer(r.responseId, r.description + " (Error)", r.responseType))
                    }
                }
                if(temp.count <= alternative.count){
                    bad.append(EvaluationQuestion(questionId: q.questionId, question: q.question, responseList: alternative))
                }
                
            }
            alternative.removeAll()
            alternative = [EvaluationAnswer]()
            
        }
        return bad
        
    }
    
    func getGoodAnswer() -> [EvaluationQuestion]{
        
        var good = [EvaluationQuestion]()
        var listToMarkToDelete = [Int]()
    
        for q in (self.evaluationAspect?.questions)!{
            
            var alternative = [EvaluationAnswer]()
            
            if (q.responseType == "OPC_SIM"){
                for r in q.responseList {
                    if (r.responseType=="RPTA_COR" && r.isSelected)
                    {
                        alternative.append(EvaluationAnswer(r.responseId, r.description + " (Correcto)", r.responseType))
                        good.append(EvaluationQuestion(questionId: q.questionId, question: q.question, responseList: alternative))
                        listToMarkToDelete.append(q.questionId)
                    }
                }
            }else{
                let temp = getCorrectAnswer(question: q)
                for r in temp {
                    if (r.responseType=="RPTA_COR" && r.isSelected){
                        alternative.append(EvaluationAnswer(r.responseId, r.description + " (Correcto)", r.responseType))
                    }
                }
                
                for r in q.responseList {
                    if (r.responseType=="RPTA_INC" && r.isSelected)
                    {
                        alternative.append(EvaluationAnswer(r.responseId, r.description + " (Correcto)", r.responseType))
                    }
                }
                
                if(temp.count == alternative.count){
                    listToMarkToDelete.append(q.questionId)
                    good.append(EvaluationQuestion(questionId: q.questionId, question: q.question, responseList: alternative))
                }
            }
            alternative.removeAll()
            alternative = [EvaluationAnswer]()
            
        }
        
        for i in listToMarkToDelete {
            let t = self.evaluationAspect?.questions.index(where: { $0.questionId == i })
            self.evaluationAspect?.questions.remove(at: t!)
        } 
        return good
    }
    
    
    func getCorrectAnswer(question : EvaluationQuestion) -> [EvaluationAnswer] {
        var alternative = [EvaluationAnswer]()
        for r in question.responseList{
            if (r.responseType == "RPTA_COR"){
                alternative.append(r)
            }
        }
        return alternative
    }
    
    func CreateResponse(){
        self.evaluationResponse = [EvaluationResponse]()
        for q in self.goodAnswer {
            var alternative = [Int]()
            for a in q.responseList{
                alternative.append(a.responseId)
            }
            evaluationResponse.append(EvaluationResponse(preguntaId: q.questionId, codPregunta: q.responseType, respuestas: alternative, esCorrecto: true))
        }
        
        for q in self.badAnswer {
            var alternative = [Int]()
            for a in q.responseList{
                alternative.append(a.responseId)
            }
            evaluationResponse.append(EvaluationResponse(preguntaId: q.questionId, codPregunta: q.responseType, respuestas: alternative, esCorrecto: false))
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
