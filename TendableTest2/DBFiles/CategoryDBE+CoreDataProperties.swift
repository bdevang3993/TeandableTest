//
//  CategoryDBE+CoreDataProperties.swift
//  TendableTest2
//
//  Created by devang bhavsar on 03/08/24.
//
//

import Foundation
import CoreData


extension CategoryDBE {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryDBE> {
        return NSFetchRequest<CategoryDBE>(entityName: "CategoryDBE")
    }
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Int64
}

extension CategoryDBE : Identifiable {

}
