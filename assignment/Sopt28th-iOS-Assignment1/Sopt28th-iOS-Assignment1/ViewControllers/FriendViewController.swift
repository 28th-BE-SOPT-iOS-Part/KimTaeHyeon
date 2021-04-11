//
//  FriendViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/11.
//

import UIKit

class FriendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func profileButtonClicked(_ sender: Any) {
        let profileVC = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(identifier: "ProfileViewController")
        profileVC.modalPresentationStyle = .overFullScreen
        present(profileVC, animated: true, completion: nil)
    }
}
