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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - 카카오계정 로그인 버튼 클릭
    @IBAction func kakaoAccountLoginButtonClicked(_ sender: Any) {
        guard let confirmVC = storyboard?.instantiateViewController(identifier: "ConfirmViewController") as? ConfirmViewController else { return }
        
        confirmVC.modalPresentationStyle = .overFullScreen
        
        self.present(confirmVC, animated: true, completion: nil)
    }
    
    // MARK: - 새로운 카카오계정 만들기 버튼 클릭
    @IBAction func makeNewKakaoAccountButtonClicked(_ sender: Any) {
        guard let signUpVC = storyboard?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController else { return }
        
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // MARK: - 확인 뷰 컨트롤러에서 다시 로그인 뷰 컨트롤러로 돌아오기 위한 메서드
    @IBAction func unwindLoginVC(segue: UIStoryboardSegue) {}
}
