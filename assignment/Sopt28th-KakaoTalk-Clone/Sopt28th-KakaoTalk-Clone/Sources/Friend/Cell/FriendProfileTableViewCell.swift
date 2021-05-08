//
//  FriendProfileTableViewCell.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

class FriendProfileTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    
    static let identifier = "FriendProfileTableViewCell"
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(imageName: String,
                 name: String,
                 stateMsg: String) {
        if let image = UIImage(named: imageName) {
            profileImage.image = image
        }
        nameLabel.text = name
        stateLabel.text = stateMsg
    }

}
