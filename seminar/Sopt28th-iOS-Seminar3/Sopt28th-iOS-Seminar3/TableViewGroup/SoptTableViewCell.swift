//
//  SoptTableViewCell.swift
//  Sopt28th-iOS-Seminar3
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

class SoptTableViewCell: UITableViewCell {
    
    // MARK: - Variable
    
    static let identifier = "SoptTableViewCell"
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(imageName: String,
                 title: String,
                 subtitle: String) {
        
        // 이미지가 nil이 아닐때만 이미지를 설정하도록 - 습관처럼 옵셔널 바인딩
        if let image = UIImage(named: imageName) {
            iconImageView.image = image
        }
        titleLabel.text = title
        subTitleLabel.text = subtitle
    }
}
