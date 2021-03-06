//
//  FriendViewController.swift
//  Sopt28th-iOS-Assignment1
//
//  Created by taehy.k on 2021/04/11.
//

import UIKit

class FriendViewController: UIViewController {

    // MARK: - Variables
    var myProfile: FriendDataModel = FriendDataModel(imageName: "profileUserImg",
                                                     name: "κΉνν",
                                                     state: "πμμμμμμπ")
    var friendList: [FriendDataModel] = []
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFriendList()
        setupTableView()
    }

    // μλ¨λ° μ€μ  λ²νΌ ν΄λ¦­μ - μ‘μμνΈνμ
    // ν­λͺ© (νΈμ§, μΉκ΅¬ κ΄λ¦¬, μΉκ΅¬ μ€μ )
    @IBAction func settingButtonClicked(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.pruneNegativeWidthConstraints()
        
        for value in ["νΈμ§", "μΉκ΅¬ κ΄λ¦¬", "μΉκ΅¬ μ€μ "] {
            actionSheet.addAction(UIAlertAction(title: value,
                                                style: .default,
                                                handler: nil))
        }
        
        let alertAction = UIAlertAction(title: "μ·¨μ",
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
                            name: "κΉλ΄",
                            state: "π±λ΄μ΄λ€"),
            FriendDataModel(imageName: "profileImage2",
                            name: "κΉμ¬λ¦",
                            state: "πββοΈμ¬λ¦μ΄λ€"),
            FriendDataModel(imageName: "profileImage3",
                            name: "κΉκ°μ",
                            state: "πκ°μμ΄λ€"),
            FriendDataModel(imageName: "profileImage4",
                            name: "κΉκ²¨μΈ",
                            state: "βοΈκ²¨μΈμ΄λ€"),
            FriendDataModel(imageName: "profileImage5",
                            name: "μμνΈ",
                            state: "λ°°κ³ νμ"),
            FriendDataModel(imageName: "profileImage6",
                            name: "μ μνΈ",
                            state: "μ‘Έλ¦¬λ€π"),
            FriendDataModel(imageName: "profileImage7",
                            name: "μ΅μνΈ",
                            state: "μνλλ¬μΌλ©΄..."),
            FriendDataModel(imageName: "profileImage8",
                            name: "μ΄μνΈ",
                            state: "λλ¬κ°κ³ μΆλ€!!!!"),
            FriendDataModel(imageName: "profileImage9",
                            name: "μ€μνΈ",
                            state: "μν λ©λ‘±π€ͺπ€ͺ"),
            FriendDataModel(imageName: "profileImage10",
                            name: "μ μνΈ",
                            state: "λ­μΌλ­μΌλ­μΌγγγγγ"),
        ])
    }
}

// MARK: - Table View Delegate
extension FriendViewController: UITableViewDelegate {
    
    // μ λμ΄ - μ λ³λ‘ λ€λ₯Έ λμ΄ λΆμ¬
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
    
    // μ ν΄λ¦­ μ λμ, νλ©΄μ νμν€κΈ°
    // [] μ ν΄λ¦­ μ μ ν μν μ μ§λμ΄μλκ±° κ³ μΉκΈ° (νμμΌλ‘ λμ΄μλ κ±°)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let profileVC = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        profileVC.modalPresentationStyle = .overFullScreen
        
        // κ³Όμ° μ΄κ² μ΅μ μ μ½λμΌκΉ? κ³ λ―ΌβΌοΈ
        // κΈ°λ³Έμ΄λ―Έμ§λ μ¬μ§ μλ κ²μ΄κ³ , κΈ°λ³Έμ΄λ¦μ κΉμνΈλ‘ νλ €κ³  switchλ¬ΈμΌλ‘ κ΅¬λΆ
        switch indexPath.section {
        // μΉκ΅¬ λͺ©λ‘λ§ indexPathλ‘ μ κ·Ό
        case 1:
            profileVC.imageName = friendList[indexPath.row].imageName
            profileVC.name = friendList[indexPath.row].name
            profileVC.state = friendList[indexPath.row].state
        default:
            profileVC.imageName = myProfile.imageName
            profileVC.name = myProfile.name
            profileVC.state = myProfile.state
        }
        
        // selection blink ν¨κ³Ό
        // λ€λ₯Έ μ μ ννκΈ° μ κΉμ§ μμ μ μ§λλ κ² ν΄μ 
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        self.present(profileVC, animated: true, completion: nil)
        
    }
    
    // μ€λ₯Έμͺ½ μ€μμ΄νμ μ·¨ν  μ‘μ
    // cf. leadingSwipeActionsConfigurationForRowAt
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // μ°¨λ¨ λ©λ΄
        let blockAction = UIContextualAction(style: .destructive,
                                              title: "μ°¨λ¨",
                                              handler: { (ac: UIContextualAction,
                                                          view: UIView,
                                                          success: (Bool) -> Void) in return })
        // μ¨κΉ λ©λ΄
        let hideAction = UIContextualAction(style: .normal,
                                            title: "μ¨κΉ",
                                            handler: { (ac: UIContextualAction,
                                                        view: UIView,
                                                        success: (Bool) -> Void) in return })
        
        // swipe menu μμ λ³κ²½ κ°λ₯
        hideAction.backgroundColor = .darkGray
        
        // λ¨Όμ  λ€μ΄κ° μμλλ‘, μ€λ₯Έμͺ½ βΆοΈ μΌμͺ½μ
        return UISwipeActionsConfiguration(actions: [blockAction, hideAction])
        
    }
    
    // Contextual Menu - λ―Έλ¦¬λ³΄κΈ°
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: {
                                            // λ―Έλ¦¬λ³΄κΈ° μ κ³΅
                                            // λ·° μΈμ€ν΄μ€ μμ±ν΄μ νλ‘ν λ·° λ―Έλ¦¬λ³΄κΈ°
                                            let vc = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
                                            
                                            if indexPath.section == 1 {
                                                vc.imageName = self.friendList[indexPath.row].imageName
                                                vc.name = self.friendList[indexPath.row].name
                                                vc.state = self.friendList[indexPath.row].state
                                            } else {
                                                vc.imageName = self.myProfile.imageName
                                                vc.name = self.myProfile.name
                                                vc.state = self.myProfile.state
                                            }
                                            
                                            return vc
                                            
                                          },
                                          actionProvider: { suggestionActions in
            
            // μ»¨νμ€νΈ λ©λ΄ κ΅¬μ±
            let chatAction = UIAction(title: "μ±ννκΈ°", image: nil) { _ in  return }
            let voiceTalkAction = UIAction(title: "λ³΄μ΄μ€ν‘", image: nil) { _ in  return }
            let faceTalkAction = UIAction(title: "νμ΄μ€ν‘", image: nil) { _ in  return }
            let giftAction = UIAction(title: "μ λ¬ΌνκΈ°", image: nil) { _ in  return }
            
            return UIMenu(title: "", children: [chatAction,
                                                voiceTalkAction,
                                                faceTalkAction,
                                                giftAction])
      })
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
            
            cell.setData(imageName: myProfile.imageName, name: myProfile.name, state: myProfile.state)
            
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

// alert controller μ¬μ©μ μ μ μλ μ μ½μ‘°κ±΄ μκΈ°λ λ¬Έμ  ν΄κ²° μν μ΅μ€νμ
// -16 μ μ½μ‘°κ±΄ κ°μ§ λ·° λͺ¨λ μ κ±°
extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
