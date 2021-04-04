//
//  ConfirmViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/03.
//

import UIKit

// 확인 뷰 컨트롤러
class ConfirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
