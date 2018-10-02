//
//  ConfigService.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 9/06/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import RealmSwift
import UIKit

extension PollService {
    
    static func updateConfig() {
        
        let url = URL(string: Constants.WEBSERVICE.settingPolls)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        DispatchQueue.main.async {
            DefaultAlamofireManager.sharedInstance.request(urlRequest).responseJSON { (response) in
                if((UIApplication.shared.delegate as! AppDelegate).sessionValid(response: response)){
                    if response.data != nil {
                        do {
                            let poll = try JSONDecoder().decode(PollSettings.self, from: response.data!)
                            let datos = poll.body
                            
                            for (key, value) in datos{
                                createAnswerFromList(name: key,  listOfData:value)
                            }
                        }catch let error as NSError {
                            print(error.description)
                        }
                    }
                }
            }
        }
    }
    
    //MARK ANSWER
    
    static func clearAnswer(name: String){
        let answerEntity : Results<AnswerBBVA> = RealmService.shared.realm.objects(AnswerBBVA.self).filter("Name = '"+name+"'")
        if(answerEntity.count>0) {
            for a in answerEntity.convertArray(ofType: AnswerBBVA.self) as [AnswerBBVA]
            {
                RealmService.shared.delete(a)
            }
        }
    }
    
    static func createAnswerFromList(name : String, listOfData : [PollAnswerSettings]){
        if (getAnswerBBVA(name: name).count > 0){
            clearAnswer(name:name)
        }
        for obj in listOfData {
            let answer = AnswerBBVA(Id:obj.id, Name: name, Code: obj.clave, Value: obj.valor)
            RealmService.shared.create(answer)
        }
    }
    
    static func getAnswerBBVA(name : String) -> ([AnswerBBVA]) {
        let realm = try! Realm()
        let answers = realm.objects(AnswerBBVA.self).filter("Name == '" + name + "'").convertArray(ofType: AnswerBBVA.self) as [AnswerBBVA]
        return answers
    }
    
    static func getAnswer(questionType : String,questionId: Int) -> [PollAnswer] {
        var bbvaList = getAnswerBBVA(name: questionType)
        var answer : [PollAnswer] = []
    
        for db in bbvaList{
            answer.append(PollAnswer(questionId: questionId , responseId: db.EntityId, name: db.Name, code: db.Code, value: db.Value))
        }
        
        return answer
    }
    
}
