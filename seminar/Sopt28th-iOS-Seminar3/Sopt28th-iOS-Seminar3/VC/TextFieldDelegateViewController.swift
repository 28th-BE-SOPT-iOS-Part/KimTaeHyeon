//
//  TextFieldDelegateViewController.swift
//  Sopt28th-iOS-Seminar3
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

class TextFieldDelegateViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var sampleTextField: UITextField!
    @IBOutlet weak var sampleLabel: UILabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        sampleTextField.delegate = self
    }

}

// MARK: - Text Field Delegate
extension TextFieldDelegateViewController: UITextFieldDelegate {
    
    // 리턴키(엔터키)눌렀을 때 발생시킬 행동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = sampleTextField.text  {
            sampleLabel.text = text
        }
        
        return true
    }
}
