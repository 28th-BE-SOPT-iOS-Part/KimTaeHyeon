//
//  ViewController.swift
//  Sopt28th-iOS-Seminar7
//
//  Created by taehy.k on 2021/05/29.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    
    /// 나중에 이 인디케이터가 호출될 때 메모리에 올라간다. (lazy의 의미)
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.frame = CGRect(x: 0, y: 0,
                                         width: 100, height: 100)
        
        activityIndicator.backgroundColor = .orange
        activityIndicator.center = self.view.center
        
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium

        // 최초의 인디케이터 상태는 멈춘 상태로 시작하기 위함
        activityIndicator.stopAnimating()
        return activityIndicator
    }()
    
    lazy var lottieView : AnimationView = {
        let animationView = AnimationView(name: "7thSeminar_Lottie_sample")
        animationView.frame = CGRect(x: 0, y: 0,
                                     width: 100, height: 100)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.stop()
        animationView.isHidden = true
    
        
        return animationView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰에 추가를 해주어야 함 (호출의 의미) -> 메모리 등록
        self.view.addSubview(lottieView)
        
    }


    @IBAction func startTapped(_ sender: Any) {
        lottieView.isHidden = false
        lottieView.play()
        
    }
    
    @IBAction func stopTapped(_ sender: Any) {
        lottieView.isHidden = true
        lottieView.stop()
    }
}

