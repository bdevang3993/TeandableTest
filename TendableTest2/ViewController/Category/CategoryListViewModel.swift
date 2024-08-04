//
//  CategoryListViewModel.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import Foundation
import UIKit

class CategoryListViewModel: NSObject {
    var objCategoryDescriptionQuery = CategoryDescriptionQuery()
    var objQuestionDescriptionQuery = QuestionDescriptionQuery()
    var objChoiceAnsDescriptionQuery = ChoiceAnsDescriptionQuery()
    var nextIndex:Int = -1
    var viewController:UIViewController?
    var arrCategory = [Categories]()
    var arrquestionListDB = [QuestionListDB]()
    func getInfo()  {
        objCategoryDescriptionQuery.getRecordsCount { result in
            self.nextIndex = result + 1
        }
    }
    
    func getAllCategoryList(allData data:@escaping(([CategoryListDB]) -> Void)) {
        objCategoryDescriptionQuery.fetchAllData { (result) in
            data(result)
        } failure: { (isFailed) in
            data([CategoryListDB]())
        }
    }
    
    func dataSaveInDataBase() {
        for value in arrCategory {
            self.saveInDatabase(value: value) { isSucess in
            }
        }
        self.questionsSaveinDatabase()
    }
    
    func saveInDatabase(value:Categories,saveData save:@escaping(Bool) -> Void) {
        let data = objCategoryDescriptionQuery.saveinDataBase(billId: value.id!, name: value.name!)
        if data {
            setAlertWithCustomAction(viewController: viewController!, message: kDataSaveSuccess, ok: { (isSuccess) in
                save(true)
            }, isCancel: false) { (isSucess) in
                save(isSucess)
            }
        }
    }
    
    func questionsSaveinDatabase() {
        for value in arrCategory {
            questionSaveQuery(value: value)
        }
    }
    func questionSaveQuery(value:Categories) {
        let arrData:[Questions] = value.questions!
        for questions in arrData {
            _ = objQuestionDescriptionQuery.saveinDataBase(id: questions.id!, name: questions.name!, c_id: value.id!, selectedAns_id: "")
            ansSaveInDatabase(value: questions)
        }
    }
    
    func ansSaveInDatabase(value:Questions) {
        let ans:[AnswerChoices] = value.answerChoices!
        for ansValue in ans {
            _ = objChoiceAnsDescriptionQuery.saveinDataBase(id: ansValue.id!, title: ansValue.name!, score: ansValue.score!, question_id: value.id!)
        }
    }
}
