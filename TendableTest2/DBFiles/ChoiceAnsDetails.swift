//
//  ChoiceAnsDetails.swift
//  TendableTest2
//
//  Created by devang bhavsar on 03/08/24.
//


import UIKit
import CoreData

struct ChoiceAnsDescriptionQuery {
    var choiceAnsDescriptionData: [NSManagedObject] = []
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ChoiceAnsDBE")
        
        //3
        do {
            choiceAnsDescriptionData = try managedContext.fetch(fetchRequest)
        } catch _ as NSError {
            
        }
        if choiceAnsDescriptionData.count > 0 {
            let array = convertToJSONArray(moArray: choiceAnsDescriptionData)
            let lastobject = array[array.count - 1]
            recordBlock(Int(lastobject["id"] as! Double))
        }
        else {
            recordBlock(-1)
        }
    }
    mutating func saveinDataBase(id:Int,title:String,score:Double,question_id:Int) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "ChoiceAnsDBE",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        person.setValue(id, forKeyPath: "id")
        person.setValue(title, forKeyPath: "title")
        person.setValue(score, forKey: "score")
        person.setValue(question_id, forKey: "question_id")
        person.setValue(0, forKey: "selected")
        // 4
        do {
            try managedContext.save()
            choiceAnsDescriptionData.append(person)
            return true
        } catch _ as NSError {
            return false
        }
    }
    
    mutating func fetchAllData(record recordBlock: @escaping (([ChoiceAnsDB]) -> Void),failure failureBlock:@escaping ((Bool) -> Void))  {
        var allData = [[String:Any]]()
        var arrCategory = [ChoiceAnsDB]()

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
            NSFetchRequest<NSManagedObject>(entityName: "ChoiceAnsDBE")
          //3
          do {
              choiceAnsDescriptionData = try managedContext.fetch(fetchRequest)
            if choiceAnsDescriptionData.count > 0 {
                arrCategory.removeAll()
                let array = convertToJSONArray(moArray: choiceAnsDescriptionData)
                allData = array
                for value in allData {
                    let objCustomer =  ChoiceAnsDB(id: value["id"] as? Int, title: value["title"] as? String, score: value["score"] as? Double, question_id: value["question_id"] as? Int,selected : value["selected"] as? Int)
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

    mutating func fetchAllDataByQUestionID(question_id:Int,record recordBlock: @escaping (([ChoiceAnsDB]) -> Void),failure failureBlock:@escaping ((Bool) -> Void))  {
        var allData = [[String:Any]]()
        var arrBillList = [ChoiceAnsDB]()

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
            NSFetchRequest<NSManagedObject>(entityName: "ChoiceAnsDBE")
            fetchRequest.predicate = NSPredicate(format: "question_id = %d",
                                                 argumentArray: [question_id])
          //3
          do {
              choiceAnsDescriptionData = try managedContext.fetch(fetchRequest)
            if choiceAnsDescriptionData.count > 0 {
                arrBillList.removeAll()
                let array = convertToJSONArray(moArray: choiceAnsDescriptionData)
                allData = array
                for value in allData {
                    let objCustomer =  ChoiceAnsDB(id: value["id"] as? Int, title: value["title"] as? String, score: value["score"] as? Double, question_id: value["question_id"] as? Int,selected: value["selected"] as? Int)
                    arrBillList.append(objCustomer)
                }
                recordBlock(arrBillList)
            } else {
                failureBlock(false)
            }
          } catch _ as NSError {
            failureBlock(false)
          }
    }
//
//
//    mutating func fetchAllDataByMonth(startDate:String,record recordBlock: @escaping (([BillList]) -> Void),failure failureBlock:@escaping ((Bool) -> Void))  {
//        var allData = [[String:Any]]()
//        var arrBillList = [BillList]()
//          guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//            failureBlock(false)
//              return
//          }
//
//          let managedContext =
//            appDelegate.persistentContainer.viewContext
//
//          //2
//          let fetchRequest =
//            NSFetchRequest<NSManagedObject>(entityName: "ChoiceAnsDBE")
//            fetchRequest.predicate = NSPredicate(format: "date CONTAINS %@",argumentArray: [startDate])
//          //3
//          do {
//            billDescriptionData = try managedContext.fetch(fetchRequest)
//            if billDescriptionData.count > 0 {
//                arrBillList.removeAll()
//                let array = FileStoragePath.objShared.convertToJSONArray(moArray: billDescriptionData)
//                allData = array
//                for value in allData {
//                    let objCustomer =  BillList(billId: value["billId"] as!Double, isPaied: value["isPaied"] as! Bool, billImage: value["billImage"] as! Data, customerName: value["customerName"] as! String, customerNumber: value["customerNumber"] as! String, date: value["date"] as! String, amount: value["amount"] as!Double,billNumber:value["billNumber"] as!String)
//                    arrBillList.append(objCustomer)
//                }
//                recordBlock(arrBillList)
//            } else {
//                failureBlock(false)
//            }
//          } catch _ as NSError {
//            failureBlock(false)
//          }
//    }
//
//
//
//
//    func update(billId:Int,isPaied:Bool) -> Bool {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChoiceAnsDBE")
//        fetchRequest.returnsObjectsAsFaults = false
//        fetchRequest.predicate = NSPredicate(format: "billId = %f",
//                                                 argumentArray: [Double(billId)])
//
//        do {
//            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
//            if results?.count != 0 {
//                results![0].setValue(isPaied, forKeyPath: "isPaied")
//            }
//        } catch {
//        }
//
//        do {
//            try context.save()
//            return true
//        }
//        catch {
//            return false
//        }
//    }
    func updateWithChoiseAns(id:Int,selected:Int) -> Bool {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChoiceAnsDBE")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id = %d",
                                                 argumentArray: [id])

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                results![0].setValue(selected, forKeyPath: "selected")
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChoiceAnsDBE")

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
