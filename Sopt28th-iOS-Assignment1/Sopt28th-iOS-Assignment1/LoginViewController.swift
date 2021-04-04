//
//  LoginViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/03.
//

import UIKit

// 로그인 뷰 컨트롤러
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 카카오계정 로그인 버튼 클릭
    @IBAction func kakaoAccountLoginButtonClicked(_ sender: Any) {
        guard let signUpVC = storyboard?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController else { return }
        
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // 새로운 카카오계정 만들기 버튼 클릭
    @IBAction func makeNewKakaoAccountButtonClicked(_ sender: Any) {
        guard let confirmVC = storyboard?.instantiateViewController(identifier: "ConfirmViewController") as? ConfirmViewController else { return }
        
        confirmVC.modalPresentationStyle = .overFullScreen
        
        self.present(confirmVC, animated: true, completion: nil)
    }
}
