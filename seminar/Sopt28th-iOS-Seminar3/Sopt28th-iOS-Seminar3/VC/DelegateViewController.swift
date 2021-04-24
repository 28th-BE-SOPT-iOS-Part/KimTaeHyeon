//
//  DelegateViewController.swift
//  Sopt28th-iOS-Seminar3
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

protocol SampleProtocol {
    func dataSend(data: String)
}

class DelegateViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var dataTextField: UITextField!
    
    // MARK: - Variables
    
//    var delegate: SampleProtocol?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBAction
    
    @IBAction func dataSendButtonClicked(_ sender: Any) {
        
        // 텍스트 필드에 값이 있을 때만 프로토콜에 텍스트 값 전달
        if let text = dataTextField.text {
            
            // sample이라는 신호를 보낼 건데, text값을 담아서 보내겠다
            NotificationCenter.default.post(name: NSNotification.Name("sample"), object: text, userInfo: nil)
            
//            delegate?.dataSend(data: text)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
