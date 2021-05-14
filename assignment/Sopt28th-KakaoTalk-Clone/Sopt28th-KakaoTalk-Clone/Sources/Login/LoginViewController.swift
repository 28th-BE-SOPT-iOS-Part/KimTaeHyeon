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
        
        // 텍스트필드 nil값 체크
        guard let emailOrPhoneNumber = emailOrPhoneNumberTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // 텍스트 필드에 값이 모두 존재할때만 로그인 시도
        if emailOrPhoneNumber.isEmpty == false && password.isEmpty == false {

            LoginDataService.shared.postLogin(email: emailOrPhoneNumber, password: password) { result in
                switch result {
                case .success(let data):
                    if let data = data as? LoginResponseDataModel {
                        self.didSuccessSignIn(data)
                    }
                case .requestErr(let message):
                    if let message = message as? String {
                        self.didFailSignIn(message)
                    }
                default:
                    print("ERROR")
                }
                

            }
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
    
    private func didSuccessSignIn(_ data: LoginResponseDataModel) {
        
        let data = data
        
        // MARK: - 토큰 저장
        // [x] 뷰컨에서 데이터 관련 처리를 직접하기보다는, 여기서 처리하는게 더 나아보임 (주관적)
        // -> 서비스 코드에서는 성공, 실패 여부만 파악하고
        // -> 데이터 처리는 뷰컨에서 한다.
        // 일단 토큰이 있든 없든 내부저장소에서 가져온다.
        let token = UserDefaults.standard.string(forKey: "token")

        // 없으면 새로 저장
        if token == nil {
            if let token = data.data?.token {
                // UserDefaults에 token 저장안되어있을때만, 새롭게 저장
                UserDefaults.standard.setValue(token, forKey: "token")
                print("토큰 새로저장: \(token)")
            }
        } else {
            print("이미 토큰 존재 \(String(describing: token))")
        }
        
        // MARK: - 통신 성공 시 홈으로 화면 전환
        self.presentAlert(title: "알림",
                          message: data.message) { _ in
            
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
