//
//  StartSectionView.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import Foundation

struct StratSection : Decodable {
    let inspection : Inspection?

    enum CodingKeys: String, CodingKey {

        case inspection = "inspection"
    }
}
struct Inspection : Decodable {
    let area : Area?
    let id : Int?
    let inspectionType : InspectionType?
    let survey : Survey?

    enum CodingKeys: String, CodingKey {

        case area = "area"
        case id = "id"
        case inspectionType = "inspectionType"
        case survey = "survey"
    }
}
struct Area : Decodable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }
}
struct InspectionType : Decodable {
    let access : String?
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case access = "access"
        case id = "id"
        case name = "name"
    }
}
struct Survey : Decodable {
    let categories : [Categories]?
    let id : Int?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
        case id = "id"
    }
}
struct Categories : Decodable {
    let id : Int?
    let name : String?
    let questions : [Questions]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case questions = "questions"
    }
}
struct Questions :Decodable {
    let answerChoices : [AnswerChoices]?
    let id : Int?
    let name : String?
    var selectedAnswerChoiceId : String?

    enum CodingKeys: String, CodingKey {

        case answerChoices = "answerChoices"
        case id = "id"
        case name = "name"
        case selectedAnswerChoiceId = "selectedAnswerChoiceId"
    }
}
struct AnswerChoices : Decodable {
    let id : Int?
    let name : String?
    let score : Double?
    var isSelected:Bool = false

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case score = "score"
    }
}
