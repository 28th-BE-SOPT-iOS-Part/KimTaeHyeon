//
//  FriendViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/11.
//

import UIKit

class FriendViewController: UIViewController {

    // MARK: - Variables
    var friendList: [FriendDataModel] = []
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFriendList()
        setupTableView()
    }

    // 상단바 설정 버튼 클릭시 - 액션시트표시
    // 항목 (편집, 친구 관리, 친구 설정)
    @IBAction func settingButtonClicked(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.pruneNegativeWidthConstraints()
        
        for value in ["편집", "친구 관리", "친구 설정"] {
            actionSheet.addAction(UIAlertAction(title: value,
                                                style: .default,
                                                handler: nil))
        }
        
        let alertAction = UIAlertAction(title: "취소",
                                        style: .cancel,
                                        handler: nil)
        actionSheet.addAction(alertAction)
        
        present(actionSheet, animated: true, completion: nil)

    }
    
}

// MARK: - Custom Function
extension FriendViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func setFriendList() {
        friendList.append(contentsOf: [
            FriendDataModel(imageName: "profileImage1",
                            name: "김봄",
                            state: "🌱봄이다"),
            FriendDataModel(imageName: "profileImage2",
                            name: "김여름",
                            state: "🏄‍♀️여름이다"),
            FriendDataModel(imageName: "profileImage3",
                            name: "김가을",
                            state: "🍁가을이다"),
            FriendDataModel(imageName: "profileImage4",
                            name: "김겨울",
                            state: "☃️겨울이다"),
            FriendDataModel(imageName: "profileImage5",
                            name: "안솝트",
                            state: "배고파요"),
            FriendDataModel(imageName: "profileImage6",
                            name: "정솝트",
                            state: "졸리다🙃"),
            FriendDataModel(imageName: "profileImage7",
                            name: "최솝트",
                            state: "시험끝났으면..."),
            FriendDataModel(imageName: "profileImage8",
                            name: "이솝트",
                            state: "놀러가고싶다!!!!"),
            FriendDataModel(imageName: "profileImage9",
                            name: "윤솝트",
                            state: "상태 메롱🤪🤪"),
            FriendDataModel(imageName: "profileImage10",
                            name: "유솝트",
                            state: "뭐야뭐야뭐야ㅏㅏㅏㅏㅏ"),
        ])
    }
}

// MARK: - Table View Delegate
extension FriendViewController: UITableViewDelegate {
    
    // 셀 높이 - 셀 별로 다른 높이 부여
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 73
        case 1:
            return 50
        default:
            return 0
        }
    }
    
    // 셀 클릭 시 동작, 화면전환시키기
    // [] 셀 클릭 시 선택 상태 유지되어있는거 고치기 (회색으로 되어있는 거)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let profileVC = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        profileVC.modalPresentationStyle = .overFullScreen
        
        // 과연 이게 최선의 코드일까? 고민‼️
        // 기본이미지는 사진 없는 것이고, 기본이름은 김솝트로 하려고 switch문으로 구분
        switch indexPath.section {
        // 친구 목록만 indexPath로 접근
        case 1:
            profileVC.imageName = friendList[indexPath.row].imageName
            profileVC.name = friendList[indexPath.row].name
        default:
            profileVC.imageName = "ProfileUserImg"
            profileVC.name = "김솝트"
        }
        
        // selection blink 효과
        // 다른 셀 선택하기 전까지 색상 유지되는 것 해제
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        self.present(profileVC, animated: true, completion: nil)
        
    }
    
    // 오른쪽 스와이프시 취할 액션
    // cf. leadingSwipeActionsConfigurationForRowAt
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // 차단 메뉴
        let blockAction = UIContextualAction(style: .destructive,
                                              title: "차단",
                                              handler: { (ac: UIContextualAction,
                                                          view: UIView,
                                                          success: (Bool) -> Void) in return })
        // 숨김 메뉴
        let hideAction = UIContextualAction(style: .normal,
                                            title: "숨김",
                                            handler: { (ac: UIContextualAction,
                                                        view: UIView,
                                                        success: (Bool) -> Void) in return })
        
        // swipe menu 색상 변경 가능
        hideAction.backgroundColor = .darkGray
        
        // 먼저 들어간 순서대로, 오른쪽 ▶︎ 왼쪽순
        return UISwipeActionsConfiguration(actions: [blockAction, hideAction])
        
    }
    
}

// MARK: - Table View Data Source
extension FriendViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return friendList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyProfileTableViewCell.identifier, for: indexPath) as? MyProfileTableViewCell else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendProfileTableViewCell.identifier, for: indexPath) as? FriendProfileTableViewCell else { return UITableViewCell() }
            
            let friends = friendList[indexPath.row]
            cell.setData(imageName: friends.imageName,
                         name: friends.name,
                         stateMsg: friends.state)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
