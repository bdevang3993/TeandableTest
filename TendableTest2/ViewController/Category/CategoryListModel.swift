//
//  CategoryListModel.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import Foundation
struct CategoryListDB {
    var id:Int?
    var name:String?
    var isCompleted:Bool?
}

struct  QuestionListDB {
    var id:Int?
    var name:String?
    var c_id:Int?
    var selectedAns_id:String?
}

struct ChoiceAnsDB {
    var id:Int?
    var title:String?
    var score:Double?
    var question_id:Int?
    var selected:Int?
}
