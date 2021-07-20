//
//  NoticeViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/07/20.
//

import UIKit


class NoticeViewController: UIViewController {
    
    @IBOutlet weak var noticeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
    }
    
    private func setInitLayout() {
        self.noticeTableView.delegate = self
        self.noticeTableView.dataSource = self
        let nib = UINib(nibName: "NoticeTableViewCell", bundle: nil)
        self.noticeTableView.register(nib, forCellReuseIdentifier: "noticeCell")
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationArrow.png"), style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.title = "알림"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 18),.foregroundColor: UIColor(white: 34/255, alpha: 1.0)]
        
        
    }
}


extension NoticeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as? NoticeTableViewCell else { return UITableViewCell()}
        cell.noticeContentLabel.text = "[중요] 6월 업데이트 사항과 새로운 기능을 확인해보세요."
        cell.noticeDateLabel.text = "8시간 전"
        return cell
    }
    
    
}
