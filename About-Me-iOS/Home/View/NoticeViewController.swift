//
//  NoticeViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/07/20.
//

import UIKit


class NoticeViewController: UIViewController {
    
    @IBOutlet weak var noticeTableView: UITableView!
    private var noticeData:[String] = ["1","2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
    }
    
    private func setInitLayout() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationArrow.png"), style: .plain, target: self, action: #selector(self.backButtonDidTap))
        self.noticeTableView.delegate = self
        self.noticeTableView.dataSource = self
        self.noticeTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.noticeTableView.separatorColor = .lineEee
        let nib = UINib(nibName: "NoticeTableViewCell", bundle: nil)
        let emptyNib = UINib(nibName: "NoticeEmptyTableViewCell", bundle: nil)
        self.noticeTableView.register(nib, forCellReuseIdentifier: "noticeCell")
        self.noticeTableView.register(emptyNib, forCellReuseIdentifier: "noticeEmptyCell")
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationController?.navigationBar.compactAppearance = navigationApp
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 18),.foregroundColor: UIColor(white: 34/255, alpha: 1.0)]
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.title = "알림"
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc
    private func backButtonDidTap(){
        self.navigationController?.popViewController(animated: true)
    }
}


extension NoticeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO : Cell Add
        if noticeData.count == 0 {
            return 1
        } else {
            return self.noticeData.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.noticeData.count == 0 {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "noticeEmptyCell", for: indexPath) as? NoticeEmptyTableViewCell
            emptyCell?.selectionStyle = .none
            tableView.isUserInteractionEnabled = false
            tableView.isScrollEnabled = false
            tableView.separatorColor = .clear
            return emptyCell!
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as? NoticeTableViewCell else { return UITableViewCell()}
            cell.noticeContentLabel.text = "[중요] 6월 업데이트 사항과 새로운 기능을 확인해보세요."
            cell.noticeDateLabel.text = "8시간 전"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                
        let cellDelete = UIContextualAction(style: .normal, title: "")  { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.noticeData.remove(at: indexPath.item)
            if self.noticeData.count == 0 {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            success(true)
        }
        cellDelete.backgroundColor = UIColor.red
        cellDelete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions:[cellDelete])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.noticeData.count == 0 {
            return 300
        } else {
            return UITableView.automaticDimension
        }
    }
    
    
}
