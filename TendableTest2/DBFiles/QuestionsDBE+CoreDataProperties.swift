//
//  QuestionsDBE+CoreDataProperties.swift
//  TendableTest2
//
//  Created by devang bhavsar on 03/08/24.
//
//

import Foundation
import CoreData


extension QuestionsDBE {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionsDBE> {
        return NSFetchRequest<QuestionsDBE>(entityName: "QuestionsDBE")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var c_id: Int64
    @NSManaged public var selectedAns_id: String?

}

extension QuestionsDBE : Identifiable {

}
