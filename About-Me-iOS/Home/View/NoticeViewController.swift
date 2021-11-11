//
//  NoticeViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/07/20.
//

import UIKit


class NoticeViewController: UIViewController {
    
    @IBOutlet weak var noticeTableView: UITableView!
    public var noticeData:[PushModelDataList] = [PushModelDataList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitLayout()
        getPushList()
    }
    
    private func setInitLayout() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationArrow.png"), style: .plain, target: self, action: #selector(self.backButtonDidTap))
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
        noticeTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        noticeTableView.separatorColor = .lineEee
        let nib = UINib(nibName: "NoticeTableViewCell", bundle: nil)
        let emptyNib = UINib(nibName: "NoticeEmptyTableViewCell", bundle: nil)
        noticeTableView.register(nib, forCellReuseIdentifier: "noticeCell")
        noticeTableView.register(emptyNib, forCellReuseIdentifier: "noticeEmptyCell")
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationController?.navigationBar.compactAppearance = navigationApp
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 18),.foregroundColor: UIColor(white: 34/255, alpha: 1.0)]
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.title = "알림"
        self.navigationController?.navigationBar.tintColor = .black
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.rightBarIcon = nil
    }
    
    private func getPushList() {
        UtilApi.getPushList(userId: USER_ID) { result in
            if case let .success(data) = result, let list = data {
                print("push result value \(result)")
                self.noticeData = list.body
                self.noticeData.reverse()
                DispatchQueue.main.async {
                    self.noticeTableView.reloadData()
                }
            }
        }
    }
    
    @objc
    private func backButtonDidTap(){
        self.navigationController?.popViewController(animated: true)
    }
}


extension NoticeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noticeData.count == 0 {
            return 1
        } else {
            return noticeData.count
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
            tableView.isUserInteractionEnabled = true
            tableView.isScrollEnabled = true
            tableView.separatorColor = .lineEee
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as? NoticeTableViewCell else { return UITableViewCell()}
            if noticeData[indexPath.row].color == "red" {
                cell.noticeImageView.image = UIImage(named: "CharacterRed")
            } else if noticeData[indexPath.row].color == "yellow" {
                cell.noticeImageView.image = UIImage(named: "characterYellow")
            } else if noticeData[indexPath.row].color == "green" {
                cell.noticeImageView.image = UIImage(named: "CharacterGreen")
            } else if noticeData[indexPath.row].color == "pink" {
                cell.noticeImageView.image = UIImage(named: "CharacterPink")
            } else if noticeData[indexPath.row].color == "purple" {
                cell.noticeImageView.image = UIImage(named: "CharacterViolet")
            } else {
                cell.noticeImageView.image = UIImage(named: "noticeFeed")
            }
            cell.noticeContentLabel.text = "\(noticeData[indexPath.row].message)"
            cell.noticeDateLabel.text = "\(noticeData[indexPath.row].updateDate)"
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
        if noticeData.count == 0 {
            return 300
        } else {
            return UITableView.automaticDimension
        }
    }
    
    
}
