//
//  ProfileViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/11.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Variables
    var panGestureRecognizer: UIPanGestureRecognizer?
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // 팬 제스처에 메서드 연결
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
    }

    // MARK: - IBAction
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Custom Function
    // 제스처 시 작동해야 할 메서드 구현
    // 모달을 스와이프로 dismiss하기 위한 메서드
    // - 애니메이션이나 transform에 대한 분석 필요 👨🏻‍🔧❗️
    // - [O] 밑에서 위로 스와이프 되는 이슈 해결
    @objc func panGestureAction(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        // 펜 제스처의 state를 스위치 문으로 관리
        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            // 아래로 내리는 행위만 가능하도록
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0,
                                         y: touchPoint.y - initialTouchPoint.y,
                                         width: self.view.frame.size.width,
                                         height: self.view.frame.size.height)
            }
        case .ended, .cancelled:
            // 화면을 1/3이상 내렸을 때만 스와이프 되도록
            if touchPoint.y - initialTouchPoint.y > (self.view.frame.height / 3) {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: self.view.frame.width,
                                             height: self.view.frame.height)
                }
            }
        default:
            break
        }
    }
}
