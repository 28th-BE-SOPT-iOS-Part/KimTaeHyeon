//
//  AnimateViewController.swift
//  Sopt28th-iOS-Seminar7
//
//  Created by taehy.k on 2021/05/29.
//

import UIKit

class AnimateViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonClicked(_ sender: Any) {
        
        // combine
        // concatenating
        
//        UIView.animate(withDuration: 4) {
//            let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
//            let rotate = CGAffineTransform(rotationAngle: .pi)
//            let move = CGAffineTransform(translationX: 100, y: 100)
//
//            let combine = scale.concatenating(rotate).concatenating(move)
//            self.imageView.transform = combine
//        } completion: { finished in
//            UIView.animate(withDuration: 2.0) {
//                self.imageView.transform = .identity // 원래대로
//            }
//        }
        
        // 오토레이아웃의 경우, 뷰가 다 그려지고 난 다음에 결정되는 부분이라
        // 애니메이션이 정상적으로 적용이 안 됨
        self.topConstraint.constant = 400
        
        UIView.animate(withDuration: 3) {
            self.view.layoutIfNeeded() // 레이아웃을 다시 그려주는 메서드
            self.imageView.alpha = 0.5
        }

    }
}
