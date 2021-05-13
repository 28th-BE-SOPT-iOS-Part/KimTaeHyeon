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
    
    private func makeParameter(email: String, password: String) -> Parameters {
        return [
            "email": email,
            "password": password
        ]
    }
    
    func postLogin(email: String,
                   password: String,
                   completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.loginURL
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
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(LoginResponseDataModel.self, from: data) else { return .pathErr }
        
        switch statusCode {
        case 200:
            // 뷰컨에서 데이터 관련 처리를 직접하기보다는, 여기서 처리하는게 더 나아보임 (주관적)
            // - 더 나은 방안이 있다면 따르고 싶음! 어렵다..어려워...
            // 일단 토큰이 있든 없든 내부저장소에서 가져온다.
            let token = UserDefaults.standard.string(forKey: "token")
            
            // 없으면 새로 저장
            if token == nil {
                if let token = decodedData.data?.token{
                    // UserDefaults에 token 저장안되어있을때만, 새롭게 저장
                    UserDefaults.standard.setValue(token, forKey: "token")
                    print("토큰 새로저장: \(token)")
                }
            } else {
                print("이미 토큰 존재 \(String(describing: token))")
            }
            return .success(decodedData.message)
        case 400: return .requestErr(decodedData.message)
        case 500: return .serverErr
        default: return .networkFail
        }
    }

}


