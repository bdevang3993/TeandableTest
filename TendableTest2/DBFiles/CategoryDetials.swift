//
//  CategoryDetials.swift
//  TendableTest2
//
//  Created by devang bhavsar on 03/08/24.
//

import UIKit
import CoreData

struct CategoryDescriptionQuery {
    var categoryDescriptionData: [NSManagedObject] = []
    mutating func getRecordsCount(record recordBlock: @escaping ((Int) -> Void)) {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            recordBlock(-1)
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CategoryDBE")
        
        //3
        do {
            categoryDescriptionData = try managedContext.fetch(fetchRequest)
        } catch _ as NSError {
            
        }
        if categoryDescriptionData.count > 0 {
            let array = convertToJSONArray(moArray: categoryDescriptionData)
            let lastobject = array[array.count - 1]
            recordBlock(Int(lastobject["id"] as! Double))
        }
        else {
            recordBlock(-1)
        }
    }
    mutating func saveinDataBase(billId:Int,name:String) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "CategoryDBE",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        person.setValue(billId, forKeyPath: "id")
        person.setValue(name, forKeyPath: "name")
        person.setValue(0, forKey: "isCompleted")
        // 4
        do {
            try managedContext.save()
            categoryDescriptionData.append(person)
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    mutating func fetchAllData(record recordBlock: @escaping (([CategoryListDB]) -> Void),failure failureBlock:@escaping ((Bool) -> Void))  {
        var allData = [[String:Any]]()
        var arrCategory = [CategoryListDB]()

          //1s
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            failureBlock(false)
              return
          }

          let managedContext =
            appDelegate.persistentContainer.viewContext

          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "CategoryDBE")
          //3
          do {
              categoryDescriptionData = try managedContext.fetch(fetchRequest)
            if categoryDescriptionData.count > 0 {
                arrCategory.removeAll()
                let array = convertToJSONArray(moArray: categoryDescriptionData)
                allData = array
                for value in allData {
                    let objCustomer =  CategoryListDB(id: (value["id"] as!Int), name: (value["name"] as! String))
                    arrCategory.append(objCustomer)
                }
                recordBlock(arrCategory)
            } else {
                failureBlock(false)
            }
          } catch _ as NSError {
            failureBlock(false)
          }
    }
    func deleteAllEntryFromDB() -> Bool {
        // Create Fetch Request
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryDBE")

        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)

        } catch {
            // Error Handling
        }
        return true
    }
}
