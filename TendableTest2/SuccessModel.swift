//
//  SuccessModel.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import Foundation
struct RegisterModel:Decodable {
    let success : Bool?
    enum CodingKeys : String, CodingKey {
        case success = "success"
    }
}
