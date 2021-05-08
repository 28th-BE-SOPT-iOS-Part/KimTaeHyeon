//
//  NetworkResult.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/05/08.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
