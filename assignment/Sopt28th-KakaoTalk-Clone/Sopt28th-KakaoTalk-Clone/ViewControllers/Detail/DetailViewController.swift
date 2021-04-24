//
//  DetailViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/25.
//

import UIKit

class DetailViewController: UIViewController {

    var menuList: [DetailMenuDataModel] = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

}

extension DetailViewController {
    
    fileprivate func configureUI() {
        
        // 일단 기본값으로 세팅하기는 하는데 이 부분은 조금 고민 필요
        userNameLabel.text = "김솝트"
        userEmailLabel.text = "apple@sopt.org"
        
        setMenuList()
        setupCollectionView()
        
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func setMenuList() {
        menuList.append(contentsOf: [
            DetailMenuDataModel(imageName: "envelope",
                                menuName: "메일"),
            DetailMenuDataModel(imageName: "calendar",
                                menuName: "캘린더"),
            DetailMenuDataModel(imageName: "tray",
                                menuName: "서랍"),
            DetailMenuDataModel(imageName: "bitcoinsign.circle",
                                menuName: "카카오콘"),
            
            DetailMenuDataModel(imageName: "gear",
                                menuName: "메이커스"),
            DetailMenuDataModel(imageName: "gift",
                                menuName: "선물하기"),
            DetailMenuDataModel(imageName: "face.smiling",
                                menuName: "이모티콘"),
            DetailMenuDataModel(imageName: "person.3",
                                menuName: "프렌즈"),
            
            DetailMenuDataModel(imageName: "cart",
                                menuName: "쇼핑하기"),
            DetailMenuDataModel(imageName: "mustache",
                                menuName: "스타일"),
            DetailMenuDataModel(imageName: "hand.raised",
                                menuName: "주문하기"),
            DetailMenuDataModel(imageName: "ticket",
                                menuName: "멜론티켓"),
            
            DetailMenuDataModel(imageName: "gamecontroller",
                                menuName: "게임"),
            DetailMenuDataModel(imageName: "music.note",
                                menuName: "멜론"),
            DetailMenuDataModel(imageName: "scissors",
                                menuName: "헤어샵"),
            DetailMenuDataModel(imageName: "square.grid.3x2",
                                menuName: "전체서비스"),
        ])
    }
}

// MARK: - Collection View Delegate
extension DetailViewController: UICollectionViewDelegate {}

// MARK: - Collection View DataSource
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMenuCollectionViewCell.identifier, for: indexPath) as? DetailMenuCollectionViewCell else { return UICollectionViewCell() }
        
        cell.iconImageView.tintColor = .black
        cell.setData(imageName: menuList[indexPath.row].imageName,
                     menuName: menuList[indexPath.row].menuName)
        
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.width
        let widthSize = screenSize * (70 / 375)
        let heightSize = screenSize * (70 / 375)
        
        return CGSize(width: widthSize, height: heightSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
