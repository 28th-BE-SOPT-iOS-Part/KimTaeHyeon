//
//  MainViewController.swift
//  Sopt28th-iOS-Seminar3
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var dataLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    // MARK: - IBAction

    @IBAction func nextButtonClicked(_ sender: Any) {
        
        // 뷰 인스턴스 생성
        guard let nextVC = storyboard?.instantiateViewController(identifier: "DelegateViewController") as? DelegateViewController else {
            return
        }
        
        // notification center는 모든 요청에게 반응을 한다 (무차별적)
        // sample이라는 신호를 받는 옵저버는 모두 신호를 받음
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataReceived),
                                               name: NSNotification.Name("sample"),
                                               object: nil)
        
        // ❗️델리게이트 위임 중요!!!!!
        // nextVC의 델리게이트는 내가(self) 처리하겠다.
//        nextVC.delegate = self
        
        // 화면 전환
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // Custom Function
    @objc func dataReceived(notification: NSNotification) {
        
        // 노티에서 오브젝트를 가져올건데 String 타입일 경우에만 가져오겠다
        // 텍스트가 빈 값이 아닐 때
        if let text = notification.object as? String, text.isEmpty == false {
            dataLabel.text = text
        }
    }
    
}

// SampleProtocol Extension

extension MainViewController: SampleProtocol {
    
    // 넘어온 data 값을 사용할건데 여기서는 라벨에 텍스트로 표시할거다
    func dataSend(data: String) {
        dataLabel.text = data
    }
    
}
