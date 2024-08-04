//
//  QuestionDetails.swift
//  TendableTest2
//
//  Created by devang bhavsar on 03/08/24.
//

import UIKit
import CoreData

struct QuestionDescriptionQuery {
    var questionDescriptionData: [NSManagedObject] = []
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "QuestionsDBE")
        
        //3
        do {
            questionDescriptionData = try managedContext.fetch(fetchRequest)
        } catch _ as NSError {
            
        }
        if questionDescriptionData.count > 0 {
            let array = convertToJSONArray(moArray: questionDescriptionData)
            let lastobject = array[array.count - 1]
            recordBlock(Int(lastobject["id"] as! Double))
        }
        else {
            recordBlock(-1)
        }
    }
    mutating func saveinDataBase(id:Int,name:String,c_id:Int,selectedAns_id:String) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "QuestionsDBE",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        person.setValue(id, forKeyPath: "id")
        person.setValue(name, forKeyPath: "name")
        person.setValue(c_id, forKey: "c_id")
        person.setValue(selectedAns_id, forKey: "selectedAns_id")
        // 4
        do {
            try managedContext.save()
            questionDescriptionData.append(person)
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    mutating func fetchAllData(record recordBlock: @escaping (([QuestionListDB]) -> Void),failure failureBlock:@escaping ((Bool) -> Void))  {
        var allData = [[String:Any]]()
        var arrCategory = [QuestionListDB]()

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
            NSFetchRequest<NSManagedObject>(entityName: "QuestionsDBE")
          //3
          do {
              questionDescriptionData = try managedContext.fetch(fetchRequest)
            if questionDescriptionData.count > 0 {
                arrCategory.removeAll()
                let array = convertToJSONArray(moArray: questionDescriptionData)
                allData = array
                for value in allData {
                    let objCustomer =  QuestionListDB(id: value["id"] as! Int,  name: value["name"] as! String, c_id: value["c_id"] as! Int, selectedAns_id: value["selectedAns_id"] as! String)
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
    func updateWithQuestionNumber(id:Int,ansid:String) -> Bool {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionsDBE")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id = %d",
                                                 argumentArray: [id])

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                results![0].setValue(ansid, forKeyPath: "selectedAns_id")
            }
        } catch {
        }

        do {
            try context.save()
            return true
        }
        catch {
            return false
        }
    }
    func deleteAllEntryFromDB() -> Bool {
        // Create Fetch Request
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionsDBE")

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
