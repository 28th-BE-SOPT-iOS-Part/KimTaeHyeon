//
//  RefreshViewController.swift
//  Sopt28th-iOS-Seminar7
//
//  Created by taehy.k on 2021/05/29.
//

import UIKit
import Lottie

class RefreshViewController: UIViewController {

    // MARK: - UI Instances
    lazy var lottieView : AnimationView = {
        let animationView = AnimationView(name: "7thSeminar_Lottie_sample")
        animationView.frame = CGRect(x: 0, y: 0,
                                     width: 50, height: 50)
    
        let centerX = UIScreen.main.bounds.width / 2
        animationView.center = CGPoint(x: centerX, y: 40)
        animationView.contentMode = .scaleAspectFit
        animationView.stop()
        animationView.isHidden = true
    
        return animationView
    }()
    /// 리프레시 컨트롤 인스턴스
    let refreshControl = UIRefreshControl()

    // MARK: - IBOutlets
    @IBOutlet weak var sampleTableView: UITableView!
    
    // MARK: - Properties
    var sampleList : [String] = ["A","B","C","D","E"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleTableView.delegate = self
        sampleTableView.dataSource = self
        initRefresh()
    }
    
    // MARK: - Custom Functions
    func initRefresh()
    {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        /// 로티 애니메이션을 추가해서 인디케이터로 사용
//        refreshControl.addSubview(lottieView)
        /// clear 해주는 이유가 기본 인디케이터를 안보이게 하려고
//        refreshControl.tintColor = .clear
        sampleTableView.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl){
        print("새로고침!")
        
        // 이 부분에 서버 통신(호출) 부분을 작성해주고 데이터를 가져오면 되는건가?
        // 그럼 리프레시 될 때 데이터가 업데이트 되는건가?
        sampleList.append("F")
        
//        lottieView.isHidden = false
//        lottieView.play()
        
        /*
         필요하면 서버 쪽 컴플리션 클로저 가져와서 해도됨
         */
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.sampleTableView.reloadData()
//            self.lottieView.isHidden = true
//            self.lottieView.stop()
            refresh.endRefreshing()
            
        }
    }
}

// MARK: - Extensions
// MARK: - Table View Delegate
extension RefreshViewController : UITableViewDelegate
{
    
}

// MARK: - Table View Data Source
extension RefreshViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sampleCell = tableView.dequeueReusableCell(withIdentifier: RefreshTableViewCell.identifier) as? RefreshTableViewCell else {return UITableViewCell() }
        
        sampleCell.setData(data: sampleList[indexPath.row])
        
        return sampleCell
    }
    
    
}


extension RefreshViewController : UIScrollViewDelegate
{
    
}
