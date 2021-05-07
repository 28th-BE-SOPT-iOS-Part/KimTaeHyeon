# 3주차 과제 DOCS

### **주제: 데이터 전달, TableView, CollectionView**

```
정말 중요한 데이터 전달 + 화면전환과 UI의 꽃(내맘대로?!!!) TableView와 CollectionView를 배워봅시다~~~
진짜 구조 복잡해지면 한도 끝도 없이 어려워질 것 같아서 기초부터 탄탄히 해야할 것 같아요...
```

## 1) 진행기간: **20210424(토) 세미나 후 ~ 20210507(금) 11:59pm**

<br>

## 2) 주요내용 (구현한 뷰)

- 일반과제 (1 ~ 3)

<img width="200" alt="week3-g1" src="https://user-images.githubusercontent.com/61109660/117447547-9ffc9900-af78-11eb-8164-09243d914c87.png">
<img width="200" alt="week3-g2" src="https://user-images.githubusercontent.com/61109660/117447541-9f640280-af78-11eb-9200-d7232bc89378.png">
<img width="200" alt="week3-g3" src="https://user-images.githubusercontent.com/61109660/117447529-9b37e500-af78-11eb-9c47-810806a3d882.png">

- 도전과제 (1 ~ 3)

<img width="200" alt="week3-c1" src="https://user-images.githubusercontent.com/61109660/117447752-d4705500-af78-11eb-8835-118bcf9b449f.png">
<img width="200" alt="week3-c2" src="https://user-images.githubusercontent.com/61109660/117447746-d33f2800-af78-11eb-94c7-5172f8a75ab1.png">
<img width="200" alt="week3-c3" src="https://user-images.githubusercontent.com/61109660/117447734-cf130a80-af78-11eb-8d1d-ec964d4b1d35.png">
---

<br>

## 3) 사용한 Skill 혹은 지식

### TableView 구현하기 (일반과제 1 관련)

- 테이블뷰 셋업

  - 저 같은 경우 테이블 뷰 구성할 때, delegate 위임하는 것을 잊지 않게 익스텐션으로 빼 놓은 곳에 setupTableView함수를 따로 만들어서 관리하는 편인데요. 테이블뷰 세팅에 관련된 코드를 하나의 함수에 만들어놓으면 관리하기 편해서 그렇습니다. 더 낳은 코드 짜는 방식이 있다면 언제든지 배울 준비가 되어있습니다 ~ 😀
    <details>
    <summary>코드 보기</summary>

    ```swift
    import UIKit

    class FriendViewController: UIViewController {

        // MARK: - Properties

        var myProfile: FriendDataModel = FriendDataModel(imageName: "profileUserImg",
                                                        name: "김태현",
                                                        state: "🍏아요아요아요🍎")
        var friendList: [FriendDataModel] = []

        // MARK: - IBOutlet

        @IBOutlet weak var tableView: UITableView!

        // MARK: - Life Cycle

        override func viewDidLoad() {
            super.viewDidLoad()

            setFriendList()
            setupTableView()
        }
        ...
    }

    // MARK: - Custom Function
    extension FriendViewController {
        func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
        }

        func setFriendList() {
            // ... 더미데이터 생략
        }
    }
    ```

    </details>

- 테이블 뷰 데이터 소스

  - TableViewDelegate와 TableViewDataSource 역시 길어지는 코드를 막기 위해서 익스텐션으로 따로 빼서 코드를 작성하고, 주석으로 코드의 위치를 파악하기 쉽게 표시하고 있습니다~ TableViewDataSource의 경우 필수로 구현해야 하는 메서드가 2가지 있었죠?! <br> numberOfRowsInSection 메서드와 cellForRowAt 메서드가 있었는데요!! <br> 섹션이나 셀이 여러개가 될 때는 분기처리를 해줘야 각각의 요소에 다른 처리를 해줄 수가 있습니다. 이 때 저는 **switch ~ case 를** 통해서 분기처리를 해줍니다. 그럼 코드가 생각보다 깔끔하게 보이더라구요!!

    <details>
    <summary> 코드 보기 </summary>
    1️⃣ numberOfRowsInSection 메서드 내에서 switch ~ case를 통해 분기처리를 하고 있는 모습

    ```swift
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

    ```

    2️⃣ cellForRowAt 메서드 내에서 switch ~ case를 통해 분기처리를 하고 있는 모습

    ```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            switch indexPath.section {
            // 첫 번째 섹션 - 마이 프로필 (마이 셀)
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyProfileTableViewCell.identifier, for: indexPath) as? MyProfileTableViewCell else { return UITableViewCell() }

                cell.setData(imageName: myProfile.imageName, name: myProfile.name, state: myProfile.state)

                return cell
            // 두 번째 섹션 - 친구 프로필 (친구 셀)
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
    ```

    </details>

<br>

### TableView Item Select → 데이터 넘겨주기! (일반과제 2 관련)

테이블뷰셀을 클릭하고 데이터를 넘겨주는 방법에는 정말 여러가지가 있을 것 같습니다. delegate를 이용해도 될 것 같고, notificationCenter를 이용할 수도 있겠죠! 이번 과제에서는 바로 다음 화면으로 데이터를 넘겨주고 있어서 그나마 간단한 방법인 다음 뷰의 프로퍼티에 직접 데이터를 넘겨주는 방식을 이용했습니다 ~~

우리는 FriendViewController에 있는 테이블 뷰의 셀을 클릭했을 때 ProfileViewController로 화면 전환하면서 데이터를 넘겨줄 것입니다.

프로퍼티를 이용한다고 했으니까 ProfileViewController에 넘겨받은 데이터를 저장할 프로퍼티를 만들어 보겠습니다.

```swift
// ProfileViewController.swift

class ProfileViewController: UIViewController {

    // MARK: - Variables
    var panGestureRecognizer: UIPanGestureRecognizer?
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

		// - 🙋🏻‍♂️ 여기에요!! 프로퍼티를 만들어 주었습니다.
    var imageName: String = ""
    var name: String = ""
    var state: String = ""

		// ... (아래 코드 생략)
```

다시 FriendViewController로 돌아와서 테이블셀 클릭 시 일어날 이벤트를 처리해주겠습니다 ~~~!!!!

이번엔 테이블 뷰에 관련한 이벤트를 처리해주기 위해 TableViewDelegate 부분을 건드려줘야 하는데요‼️

그 중에서 셀 선택, 클릭에 관련한 이벤트는 didSelectRowAt 메서드를 이용합니다.

```swift
// MARK: - Table View Delegate
extension FriendViewController: UITableViewDelegate {

		// ... (코드 중략)

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
            profileVC.state = friendList[indexPath.row].state
        default:
            profileVC.imageName = myProfile.imageName
            profileVC.name = myProfile.name
            profileVC.state = myProfile.state
        }

        // selection blink 효과
        // 다른 셀 선택하기 전까지 색상 유지되는 것 해제
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07) {
            tableView.deselectRow(at: indexPath, animated: true)
        }

        self.present(profileVC, animated: true, completion: nil)

    }

		// ... (코드 중략)
}
```

화면 전환을 위해서 뷰 인스턴스를 생성하고 present()메서드를 이용하고 있습니다. 그리고 데이터를 넘겨주기 위해서 중간에 처리를 하나 해주고 있죠?!! 뷰 인스턴스의 프로퍼티에 값을 전달하면서 넘겨주고 있습니다.

지금은 셀 별로 넘어가는 데이터가 다르기 때문에 분기 처리까지 해주고 있어요 !!!!!! 🙂

<br>

### CollectionView 구현하기 (일반과제 3 관련)

컬렉션뷰 셋업 같은 경우도 위에 테이블뷰 셋업 처럼 처리하고 있어여~~!! 위에서 참고해주세요~!~!~!

ha ha ,,, 허전하니까 여기에도 코드 추가!!!

```swift
// DetailViewController.swift
// 더보기 탭 구현한 뷰 컨트롤러

extension DetailViewController {

		// UI 셋업
    fileprivate func configureUI() {

        // 일단 기본값으로 세팅하기는 하는데 이 부분은 조금 고민 필요
        userNameLabel.text = "김솝트"
        userEmailLabel.text = "apple@sopt.org"

        setMenuList()
        setupCollectionView()

    }

		// 컬렉션 뷰 셋업
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

		// 더미데이터 넣는 함수
    fileprivate func setMenuList() {
			// ... (내용 생략)
		}

}
```

**CollectionView DataSource**

컬렉션뷰에는 무엇도 있다?!!!! 플로우레이아웃도 있다⭐️ 레이아웃을 잡아주기 위해 정말 중요한 녀석들인데 이번에 세미나 하면서 정리가 확실히 되었습니다..ㅎㅎ **(팟장님께 깊은 감사를 전합니다🙇🏻‍♂️)**

다음 4가지를 기억합시다~~

**CollectionViewDelegateFlowLayout**

1. sizeForItemAt: 아이의 크기 조정
2. minimumLineSpacing: 줄간 간격 조정
3. minimumInteritemSpacing: 아이템간 간격 조정
4. insetForSectionAt: 컬렉션뷰의 여백공간 조정 (padding)

```swift
// MARK: - Collection View Delegate Flow Layout

extension DetailViewController: UICollectionViewDelegateFlowLayout {

		// 셀 크기 조정하기!! (스크린 사이즈를 잡아주고 들어가야, 모든 기기에서 동일한 비율을 얻을 수 있음)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.width
        let widthSize = screenSize * (70 / 375)
        let heightSize = screenSize * (70 / 375)

        return CGSize(width: widthSize, height: heightSize)
    }

		// 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

		// 아이템 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }

		// 컬렉션뷰 여백 (padding)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
```

### 도전과제 내용 정리는 다시 하도록 할게요 ...❗️
