//
//  LoginResponseDataModel.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/05/08.
//

/*
 {
     "success": true,
     "message": "로그인 성공 ^o^",
     "data": {
         "UserId": 112,
         "user_nickname": "sopt_tes",
         "token": "{ 생략 ...}"
     }
 }
 */

import Foundation

struct LoginResponseDataModel: Codable {
    let success: Bool
    let message: String
    let data: LoginResponse?
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
}

// MARK: - DataClass
struct LoginResponse: Codable {
    let userID: Int
    let userNickname, token: String

    // CodingKeys 부분?!
    enum CodingKeys: String, CodingKey {
        case userID = "UserId"
        case userNickname = "user_nickname"
        case token
    }
}
