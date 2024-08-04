//
//  LoginViewModel.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import Foundation

class LoginViewModel: NSObject {
    
    func setupEmailValidation(emailId:String) -> Bool {
        return emailId.isValidEmail
    }
}
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
