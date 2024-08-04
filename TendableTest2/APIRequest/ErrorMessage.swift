//
//  ErrorMessage.swift
//  APIRequestArchitecture
//
//  Created by devang bhavsar on 02/04/22.
//

import UIKit
enum ErrorMessages {
    case interNetCheck,serverSide,clientSide,urlSide
    func value() -> String {
        switch self {
        case .interNetCheck:
            return "Please check Internet Connection"
        case .serverSide:
            return "Server Side Error please check with server provider people"
        case .clientSide:
            return "Client Side error please check for passing parametter and it's type"
        case .urlSide:
            return "Please check URL Request issue in Parameter set up for URL"
        default:
            return "Please check Internet Connection"
        }
    }
}
enum EmaildIdCheck {
case emaildNotValied,passwordIncorrect,emailorPasswordincorrect
    func value() -> String {
        switch self {
        case .emaildNotValied:
            return "please check valied email id"
        case .passwordIncorrect:
            return "Check for the password"
        case .emailorPasswordincorrect:
            return "email id or password is incorrect"
        }
    }
    
}
