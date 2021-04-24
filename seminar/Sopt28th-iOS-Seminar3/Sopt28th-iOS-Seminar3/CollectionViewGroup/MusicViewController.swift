//
//  MusicViewController.swift
//  Sopt28th-iOS-Seminar3
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

class MusicViewController: UIViewController {
    
    private var musicList: [MusicDataModel] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMusicList()
        setupCollectionView()
    }

}

extension MusicViewController {
    
    fileprivate func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    fileprivate func setMusicList()
    {
        musicList.append(contentsOf: [
            MusicDataModel(coverName: "musicAlbum1",
                           musicTitle: "가습기",
                           singer: "한요한"),
            
            MusicDataModel(coverName: "musicAlbum2",
                           musicTitle: "Thick and Thin",
                           singer: "LANY"),
            
            MusicDataModel(coverName: "musicAlbum3",
                           musicTitle: "시공간",
                           singer: "기리보이"),
            
            MusicDataModel(coverName: "musicAlbum4",
                           musicTitle: "NISEKOI",
                           singer: "Futuristic Swaver")
        ])
    }
    
}

extension MusicViewController: UICollectionViewDelegate {
    
}

extension MusicViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(imageName: musicList[indexPath.row].coverName,
                     title: musicList[indexPath.row].musicTitle,
                     subtitle: musicList[indexPath.row].singer)
        
        return cell
        
    }
    
}

// 총 4개의 메서드를 이용해서 컬렉션뷰셀의 레이아웃(크기, 위치) 조정
extension MusicViewController: UICollectionViewDelegateFlowLayout {
    
    // 셀의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.width
        
        let cellWidth = screenSize * (177/375)
        let cellHeight = screenSize * (205/375)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // 상하간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // 좌우간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    // content 외부 inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
