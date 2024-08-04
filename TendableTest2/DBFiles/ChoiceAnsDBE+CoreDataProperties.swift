//
//  ChoiceAnsDBE+CoreDataProperties.swift
//  TendableTest2
//
//  Created by devang bhavsar on 03/08/24.
//
//

import Foundation
import CoreData


extension ChoiceAnsDBE {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChoiceAnsDBE> {
        return NSFetchRequest<ChoiceAnsDBE>(entityName: "ChoiceAnsDBE")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var score: Double
    @NSManaged public var question_id: Int64
    @NSManaged public var selected: Int64

}

extension ChoiceAnsDBE : Identifiable {

}
