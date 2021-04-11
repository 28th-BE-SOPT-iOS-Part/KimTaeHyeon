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
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translationY = panGesture.translation(in: panGesture.view!).y

        // 팬 제스처의 state를 switch문으로 관리
        // - 제스처에 대한 이해 필요
        switch panGesture.state {
        case .began:
            break
        case .changed:
            view.transform = CGAffineTransform(translationX: 0, y: translationY)
        case .ended, .cancelled:
            if translationY > 160 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            }
        case .failed, .possible:
            break
        @unknown default:
            break
        }
    }
}
