//
//  MusicCollectionViewCell.swift
//  Sopt28th-iOS-Seminar3
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MusicCollectionViewCell"
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func setData(imageName: String,
                 title: String,
                 subtitle: String) {
        if let image = UIImage(named: imageName) {
            albumImageView.image = image
        }
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
