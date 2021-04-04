//
//  SignUpViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/03.
//

import UIKit

// 회원가입 뷰 컨트롤러
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailOrPhoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func makeNewKakaoAccountButtonClicked(_ sender: Any) {
        guard let confirmVC = storyboard?.instantiateViewController(identifier: "ConfirmViewController") as? ConfirmViewController else { return }
        
        confirmVC.modalPresentationStyle = .overFullScreen
        
        self.present(confirmVC, animated: true, completion: nil)
    }
}
