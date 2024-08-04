//
//  QuastionAndAnsViewModel.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import Foundation
import CoreData
import UIKit
class QuastionAndAnsViewModel: NSObject {
    var objQuestionDescriptionQuery = QuestionDescriptionQuery()
    var objChoiceAnsDescriptionQuery = ChoiceAnsDescriptionQuery()
    var viewController:UIViewController?
    var arrQuestion = [QuestionListDB]()
    var arrChoice = [ChoiceAnsDB]()
    func getquestionFromDB() {
        let data = objQuestionDescriptionQuery.fetchAllData { arrQuestionData in
            self.arrQuestion = arrQuestionData
        } failure: { error in
            Alert().showAlert(message: "Data not found", viewController: self.viewController!)
        }
    }
    
    func getAnsFromDB(questionId:Int) {
        _ = objChoiceAnsDescriptionQuery.fetchAllDataByQUestionID(question_id: questionId) { arrchoice in
            self.arrChoice = arrchoice
        } failure: { error in
            Alert().showAlert(message: "Data not found", viewController: self.viewController!)
        }

    }
    
    func updateSelectedAnsInDB(id:Int,selected:Int) {
        let data = objChoiceAnsDescriptionQuery.updateWithChoiseAns(id: id, selected: selected)
        print("Udate Data = \(data)")
        
        let data1 = objChoiceAnsDescriptionQuery.fetchAllData { arrData in
            print("All Data = \(arrData)")
        } failure: { error in
        }

        
    }
    
}
