//
//  MyProfileTableViewCell.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {
    
    static let identifier = "MyProfileTableViewCell"

    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var stateMessageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(imageName: String, name: String, state: String) {
        if let image = UIImage(named: imageName) {
            myProfileImageView.image = image
        }
        userNameLabel.text = name
        stateMessageLabel.text = state
    }
}
