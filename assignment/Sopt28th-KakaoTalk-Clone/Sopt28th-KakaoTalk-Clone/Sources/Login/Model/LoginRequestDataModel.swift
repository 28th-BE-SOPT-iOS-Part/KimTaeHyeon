//
//  LoginRequestDataModel.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/05/08.
//

/*
 {
     "email" : "test1",
     "password" : "1111"
 }
 */

import Foundation

struct LoginRequestDataModel: Encodable {
    var email: String
    var password: String
}
