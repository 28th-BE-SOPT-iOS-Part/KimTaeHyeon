//
//  SignUpViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/03.
//

import UIKit

// 2번 뷰 컨트롤러
// 회원가입 뷰 컨트롤러
class SignUpViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailOrPhoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var createKakaoAccountButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - 새로운 카카오계정 만들기 버튼 클릭
    @IBAction func makeNewKakaoAccountButtonClicked(_ sender: Any) {

        // 원래는 텍스트 필드에 모두 값이 있을 때만 버튼을 활성화 시키려고 했는데
        // 알림 중에서 "필요한 값이 존재하지 않습니다."라는 메시지가 있어서 빈 값 일때도 버튼 활성화
        
        guard let emailOrPhoneNumber = emailOrPhoneNumberTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let passwordConfirm = passwordConfirmTextField.text else { return }
        
        // 비밀번호 같을 때만
        if password == passwordConfirm {
            
            SignUpDataService.shared.postSignUp(email: emailOrPhoneNumber, password: password) { result in
                
                switch result {
                case .success(let message):
                    if let message = message as? String {
                        self.didSuccessSignIn(message)
                    }
                case .requestErr(let message):
                    if let message = message as? String {
                        self.didFailSignIn(message)
                    }
                default:
                    print("ERROR")
                }
            }
        } else {
            self.presentAlert(title: "알림", message: "비밀번호가 같은지 확인해주세요.", okAction: nil)
        }
        

    }
}

// MARK: - Custom Function
extension SignUpViewController {
    private func configureUI() {
        emailOrPhoneNumberTextField.useUnderline()
        passwordTextField.useUnderline()
        passwordConfirmTextField.useUnderline()
        createKakaoAccountButton.layer.cornerRadius = 4
    }
    
    private func didSuccessSignIn(_ message: String) {
        self.presentAlert(title: "알림",
                          message: message) { _ in
            
            // 같은 스토리보드 내에 있는 것이 아니라, 다른 스토리보드에 있을 때는 UIStoryboard를 이용해서 인스턴스 생성
            let homeVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "HomeTabBarController")
            homeVC.modalPresentationStyle = .overFullScreen
            
            self.present(homeVC, animated: true, completion: nil)
            
        }
    }
    
    private func didFailSignIn(_ message: String) {
        self.presentAlert(title: "알림",
                          message: message,
                          okAction: nil)
    }
}
