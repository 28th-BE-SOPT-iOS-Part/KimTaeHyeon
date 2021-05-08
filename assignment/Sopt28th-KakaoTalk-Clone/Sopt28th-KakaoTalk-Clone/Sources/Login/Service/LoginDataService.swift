//
//  LoginDataService.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/05/08.
//

import Foundation
import Alamofire

struct LoginDataService {
    
    // 싱글톤 패턴으로 여러 뷰컨에서 같은 인스턴스에 접근가능하게 설정
    static let shared = LoginDataService()
    
    func postLogin(_ parameters: LoginRequestDataModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.loginURL
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: parameters,
                                     headers: nil)
        
        dataRequest.responseData { (dataResponse) in
            
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value)
            case .failure: completion(.pathErr)
            }
            
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodeData = try? decoder.decode(LoginResponseDataModel.self, from: data) else { return .pathErr }
        return .success(decodeData.data)
    }

}


