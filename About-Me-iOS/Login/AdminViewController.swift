//
//  AdminViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/12/16.
//

import UIKit

class AdminViewController: UIViewController {
    
    @IBOutlet weak var adminTableView: UITableView!
    var adminBlcokInfo:[AdminBlockModel?] = []
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutInit()
        getAdminBloakInfo()
        print("adminBlock Data Info\(adminBlcokInfo)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAdminBloakInfo()
        self.navigationController?.navigationBar.tintColor = .black
        print("adminBlock ViewWillAppear Info\(adminBlcokInfo)")
    }
    private func getAdminBloakInfo() {
        UtilApi.getAdminBlockList { [self] result in
            if result.errorCode == "404" {
                adminBlcokInfo = []
                DispatchQueue.main.async {
                    adminTableView.reloadData()
                }
            } else {
                adminBlcokInfo = result.body!
                DispatchQueue.main.async {
                    adminTableView.reloadData()
                }
            }
        }
    }
    
    private func setLayoutInit() {
        let titleLabel = UILabel()
        titleLabel.text = "신고관리"
        titleLabel.textColor = .gray333
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        self.navigationItem.titleView = titleLabel
        adminTableView.delegate = self
        adminTableView.dataSource = self
        adminTableView.separatorColor = .lineEee
        adminTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        adminTableView.tableFooterView = UIView()
    }
    
    private func configureCell(indexPath: IndexPath) {
        DispatchQueue.main.async { [self] in
            let cell = adminTableView.cellForRow(at: indexPath)
            cell?.textLabel?.text = self.adminBlcokInfo[indexPath.row]!.sueReason
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
            cell?.textLabel?.lineBreakMode = .byCharWrapping
            cell?.textLabel?.textColor = .gray333
            cell?.accessoryView = UIImageView.init(image: UIImage(named: "Arrow_Profile"))
        }
    }
    
    private func selectCell(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let adminBlockView = storyboard.instantiateViewController(withIdentifier: "AdminBlockVC") as? AdminBlockViewController
        guard let adminBlockVC = adminBlockView else { return }
        adminBlockVC.adminDetailInfo = adminBlcokInfo[indexPath.row]
        self.navigationController?.pushViewController(adminBlockVC, animated: true)
    }
    
}


extension AdminViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminBlcokInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminCell", for: indexPath)
        
        configureCell(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    
}
