//
//  SignUpDataModel.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/05/14.
//

/*
 {
     "success": true,
     "message": "회원가입에 성공했슴다^0^",
     "data": {
         "nickname": "sopt_test"
     }
 }
 */

import Foundation

struct SignUpDataModel: Codable {
    var success: Bool
    var message: String
    var data: SignUpResponse?
}

struct SignUpResponse: Codable {
    var nickname: String
}


