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
        // 뷰컨 인스턴스 생성
        guard let confirmVC = storyboard?.instantiateViewController(identifier: "ConfirmViewController") as? ConfirmViewController else { return }
        confirmVC.modalPresentationStyle = .overFullScreen
        
        // 텍스트필드 nil값 체크
        guard let emailOrPhoneNumber = emailOrPhoneNumberTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let passwordConfirm = passwordConfirmTextField.text else { return }
        
        // - 텍스트필드에 모두 값 존재할때만
        // - 비밀번호와 비밀번호 확인의 값이 같을때만
        if emailOrPhoneNumber.isEmpty == false && password.isEmpty == false && passwordConfirm.isEmpty == false {
            if password == passwordConfirm {
                confirmVC.emailOrPhoneNumber = emailOrPhoneNumber
                self.present(confirmVC, animated: true, completion: nil)
            }
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
}
