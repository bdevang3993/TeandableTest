//
//  Constant.swift
//  TendablezTest
//
// Created by devang bhavsar on 01/08/24.
//

import Foundation
import UIKit
import CoreData
//import CoreLocation

//MARK:- Screen Resolution
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

let kMainStoryBoard = "Main"
var isDataBaseAvailable:Bool = false
let kAppName = "Tendable"
let kEmail = "email"
let kPassword = "password"
var kStratSection:StratSection?
let userDefault = UserDefaults.standard
var kDataSaveSuccess = "Data save sucessfully"

//MARK:- TypeDefine Declaration
typealias TASelectedIndex = (Int) -> Void
typealias TaSelectedValueSuccess = (String) -> Void

//MARK:- Constant API URL
let kbaseURL = "http://127.0.0.1:5001/api/"
let kregisterURL = "register"
let kloginURL = "login"
let kStartSection = "inspections/start"
let kEndSection = "inspections/submit"
//MARK:- Constant Struct
typealias reloadTableViewClosure = () -> Void
struct AppMessage {
    var internetIssue:String = "Please check the internet connection"
}

struct Alert {
    func showAlert(message:String,viewController:UIViewController) {
        let alert = UIAlertController(title:kAppName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

func setAlertWithCustomAction(viewController:UIViewController,message:String,ok okBlock: @escaping ((Bool) -> Void),isCancel:Bool,cancel cancelBlock: @escaping ((Bool) -> Void)) {
    let alertController = UIAlertController(title: kAppName, message:message, preferredStyle: .alert)
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
        okBlock(true)
    }
    alertController.addAction(okAction)
    if isCancel {
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
            cancelBlock(true)
        }
        alertController.addAction(cancelAction)
    }
    viewController.present(alertController, animated: true, completion: nil)
}
func convertToJSONArray(moArray: [NSManagedObject]) -> [[String:Any]] {
    var jsonArray: [[String: Any]] = []
    for item in moArray {
        var dict: [String: Any] = [:]
        for attribute in item.entity.attributesByName {
            //check if value is present, then add key to dictionary so as to avoid the nil value crash
            if let value = item.value(forKey: attribute.key) {
                dict[attribute.key] = value
            }
        }
        jsonArray.append(dict)
    }
    return jsonArray
}

func convertDictionaryToJSON(_ dictionary: [String: Any]) -> String? {

   guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
      print("Something is wrong while converting dictionary to JSON data.")
      return nil
   }

   guard let jsonString = String(data: jsonData, encoding: .utf8) else {
      print("Something is wrong while converting JSON data to JSON string.")
      return nil
   }

   return jsonString
}
