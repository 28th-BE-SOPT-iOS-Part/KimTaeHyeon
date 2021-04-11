//
//  ConfirmViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/03.
//

import UIKit

// 3번 뷰 컨트롤러
// 확인 뷰 컨트롤러
class ConfirmViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userLabel: UILabel!
    
    // MARK: - Variables
    var emailOrPhoneNumber: String?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 라벨에 프로퍼티로 넘어온 값 설정 (데이터 전달)
        if let emailOrPhoneNumber = self.emailOrPhoneNumber {
            userLabel.text = "\(emailOrPhoneNumber)님"
        }   
    }

}
