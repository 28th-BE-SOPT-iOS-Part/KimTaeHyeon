//
//  LoginViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/03.
//

import UIKit

// 1번 뷰 컨트롤러
// 로그인 뷰 컨트롤러
class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var emailOrPhoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var buttons: [UIButton]!
    
    // MARK: - Variables
    let border: CALayer? = nil
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 첫화면으로 돌아왔을 때 텍스트 필드 초기화
        emailOrPhoneNumberTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: - 카카오계정 로그인 버튼 클릭
    @IBAction func kakaoAccountLoginButtonClicked(_ sender: Any) {
        // 뷰컨 인스턴스 생성
        guard let confirmVC = storyboard?.instantiateViewController(identifier: "ConfirmViewController") as? ConfirmViewController else { return }
        confirmVC.modalPresentationStyle = .overFullScreen
        
        // 텍스트필드 nil값 체크
        guard let emailOrPhoneNumber = emailOrPhoneNumberTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // 텍스트 필드에 값이 모두 존재할때만 화면전환
        if emailOrPhoneNumber.isEmpty == false && password.isEmpty == false {
            confirmVC.emailOrPhoneNumber = emailOrPhoneNumber
            self.present(confirmVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - 새로운 카카오계정 만들기 버튼 클릭
    @IBAction func makeNewKakaoAccountButtonClicked(_ sender: Any) {
        guard let signUpVC = storyboard?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController else { return }
        
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // MARK: - 확인 뷰 컨트롤러에서 다시 로그인 뷰 컨트롤러로 돌아오기 위한 메서드
    @IBAction func unwindLoginVC(segue: UIStoryboardSegue) {}
}

// MARK: - Custom Function
extension LoginViewController {
    // UI셋업
    private func configureUI() {
        // 텍스트 필드 밑줄
        emailOrPhoneNumberTextField.useUnderline()
        passwordTextField.useUnderline()
        
        // 테두리 둥글게
        for button in buttons {
            button.layer.cornerRadius = 4
        }
    }
}

// MARK: - UITextField Extension
extension UITextField {
    // 텍스트필드에 밑줄을 추가하기 위한 메서드
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
