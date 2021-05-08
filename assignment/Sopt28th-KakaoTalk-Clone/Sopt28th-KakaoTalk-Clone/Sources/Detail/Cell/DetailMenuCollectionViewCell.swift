//
//  DetailMenuCollectionViewCell.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/25.
//

import UIKit

class DetailMenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailMenuCollectionViewCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    
    func setData(imageName: String,
                 menuName: String) {
        if let image = UIImage(systemName: imageName) {
            iconImageView.image = image
        }
        menuNameLabel.text = menuName
    }
}
