//
//  EvaluationResultVC.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 15/07/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit
import Charts
import UserNotifications

class EvaluationResultVC:  BaseVC {
    
    @IBOutlet weak var chart    : PieChartView!
    @IBOutlet weak var result   : UILabel!
    @IBOutlet weak var resultTxt: UILabel!
    
    var goodEntry      = PieChartDataEntry(value: 0)
    var badEntry       = PieChartDataEntry(value: 0)
    
    var percent         = 0.0
    var collectionEnry  = [PieChartDataEntry]()
    var goodAnswer      = [EvaluationQuestion]()
    var badAnswer       = [EvaluationQuestion]()
    
    var currentResponse = [EvaluationQuestion](){
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellHeaderIdentifier = "EvaluationResultHTVC"
    let cellIdentifier       = "EvaluationResultTVC"
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        chart.delegate = self
        chart.backgroundColor = UIColor.white
        chart.chartDescription?.text = "Resultados"
        chart.chartDescription?.font = UIFont(name: "Helvetica Neue", size: 15)!
        
        goodEntry.value = Double(goodAnswer.count)
        goodEntry.label = "Buenas"
        
        badEntry.value = Double(badAnswer.count)
        badEntry.label = "Malas"
        
        collectionEnry = [goodEntry,badEntry]
        let number = goodAnswer.count*100/(goodAnswer.count+badAnswer.count)
        result.text = "\(number)%"
        resultTxt.text = (Double(number) >= percent) ? "Aprovado" : "Desaprobado"
        
        if(badAnswer.count == 0){
            currentResponse = goodAnswer
        }
        
        if(goodAnswer.count == 0){
            currentResponse = badAnswer
        }
        
        setupNib()
        updateChartData()
        
    }
    
    func setupNib(){
        let nibCell = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: cellIdentifier)
    }
    
    func updateChartData (){
        let chartDataSet = PieChartDataSet(values: collectionEnry, label:nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let color = [UIColor.BBVADARKAQUA(),UIColor.BBVAWHITEMEDIUMBLUE()]
        chartDataSet.colors = color
        
        chart.data = chartData
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        chart.data?.setValueFormatter(DefaultValueFormatter(formatter:formatter))
    }
    @IBAction func backToDashBoard(_ sender: Any) {
  
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        self.present(vc, animated: true, completion: nil)
 
    }
    
}

extension EvaluationResultVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("currentResponse.count"+"\(currentResponse.count)")
        return currentResponse.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = Bundle.main.loadNibNamed(cellHeaderIdentifier, owner: self, options: nil)?.first as! EvaluationResultHTVC
        if(currentResponse.count>0){
            cell.question.text = currentResponse[section].question
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Pedro numberOfRowsInSection " +  "\(currentResponse[section].responseList.count)")
        return (currentResponse[section].responseList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! EvaluationResultTVC
        let alternative = currentResponse[indexPath.section].responseList[indexPath.row]
        cell.type = alternative.responseType
        print("Pedro alternative.responseType" + alternative.responseType)
        cell.alternativa.text = alternative.description
        return cell
    }
}

extension EvaluationResultVC : ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if ((entry as! PieChartDataEntry).label == "Buenas" ){
            currentResponse = goodAnswer
        }else{
            currentResponse = badAnswer
        }
    }
}
