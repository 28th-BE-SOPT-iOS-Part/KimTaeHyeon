//
//  SignUpDataService.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/05/14.
//

import Alamofire

struct SignUpDataService {
    static let shared = SignUpDataService()
    
    // 파라미터 리턴 함수
    private func makeParameter(email: String, password: String) -> Parameters {
        return [
            "email": email,
            "password": password,
            "sex" : "0",
            "nickname" : "sopt_test",
            "phone" : "010-1010-2020",
            "birth" : "1996-02-24"
        ]
    }
    
    // 회원가입 요청
    func postSignUp(email: String,
                    password: String,
                    completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.signupURL
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: makeParameter(email: email, password: password),
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { (dataResponse) in
            
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure: completion(.pathErr)
            }
            
        }
    }
    
    // 상태코드 판단
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(SignUpDataModel.self, from: data)
        else { return .pathErr}
        
        switch statusCode {
        
        case 200: return .success(decodedData.message)
        case 400: return .requestErr(decodedData.message)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
