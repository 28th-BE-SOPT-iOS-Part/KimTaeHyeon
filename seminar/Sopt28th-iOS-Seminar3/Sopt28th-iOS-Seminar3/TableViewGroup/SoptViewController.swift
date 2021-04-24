//
//  SoptViewController.swift
//  Sopt28th-iOS-Seminar3
//
//  Created by taehy.k on 2021/04/24.
//

import UIKit

class SoptViewController: UIViewController {
    
    // MARK: - Variables
    var serviceList: [ServiceListDataModel] = []
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setServiceList()
        // 과연 데이터를 먼저 세팅하는 것과 테이블뷰를 세팅하는 것과 순서적으로 차이가 있을까?
        setupTableView()
    }

}

extension SoptViewController {
    func configureUI() {
        self.view.backgroundColor =  .black
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
    }
    
    func setServiceList()
    {
        serviceList.append(contentsOf: [
            ServiceListDataModel(iconImageName: "soptAppIcon1",
                                 title: "OUNCE - 집사를 위한 똑똑한 기록장",
                                 subtitle: "우리 고양이의 까다로운 입맛 정리 서비스"),
            
            ServiceListDataModel(iconImageName: "soptAppIcon2",
                                 title: "포켓유니브",
                                 subtitle: "MZ세대를 위한, 올인원 대학생활 관리 플랫폼"),
            
            ServiceListDataModel(iconImageName: "soptAppIcon3",
                                 title: "MOMO",
                                 subtitle: "책 속의 문장과 함께 쓰는 일기"),
            
            ServiceListDataModel(iconImageName: "soptAppIcon4",
                                 title: "Weathy(웨디)",
                                 subtitle: "나에게 돌아오는 맞춤 날씨 서비스"),
            
            ServiceListDataModel(iconImageName: "soptAppIcon5",
                                 title: "BeMe",
                                 subtitle: "나를 알아가는 질문 다이어리"),
            
            ServiceListDataModel(iconImageName: "soptAppIcon6",
                                 title: "placepic",
                                 subtitle: "우리들끼리 공유하는 최애장소, 플레이스픽"),
            
            ServiceListDataModel(iconImageName: "soptAppIcon7",
                                 title: "몽글(Mongle)",
                                 subtitle: "우리가 만드는 문장 큐레이션 플랫폼, 몽글")
        ])
    }
}

extension SoptViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106 // 셀 높이를 106으로 고정하겠다.
    }
    
}

extension SoptViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoptTableViewCell.identifier, for: indexPath) as? SoptTableViewCell else { return UITableViewCell() }
        
        cell.setData(imageName: serviceList[indexPath.row].iconImageName,
                     title: serviceList[indexPath.row].title,
                     subtitle: serviceList[indexPath.row].subtitle)
        cell.backgroundColor = .clear
        return cell
    }
}
